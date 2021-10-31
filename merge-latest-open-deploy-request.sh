#!/bin/bash

#unset PLANETSCALE_SERVICE_TOKEN

if [ -z "$MY_DB_URL" ]; then
    echo "MY_DB_URL not set, using default database - this will potentially interfere with demos of other people, are you sure to proceed?"
    read -p "Press enter to continue, or ctrl-c to abort"
    DB_NAME="matrix-demos"
else
    echo "MY_DB_URL set, using your personal database"
    export DATABASE_URL="$MY_DB_URL"
    DB_NAME="matrix-demos-${GITHUB_USER}"
fi

ORG_NAME="planetscale-demo"

. use-pscale-docker-image.sh
. wait-for-deploy-request-merged.sh

raw_output=`pscale deploy-request list "$DB_NAME" --org "$ORG_NAME" --format json`
# check return code, if not 0 then error
if [ $? -ne 0 ]; then
    echo "Error: pscale deploy-branch list returned non-zero exit code $?: $raw_output"
    exit 1
fi
output=`echo $raw_output | jq "[.[] | select(.state == \"open\") ] | .[0].number "`

# test whether the output is a number
if [[ $output =~ ^[0-9]+$ ]]; then
    echo "Going to deploy latest open deployment request $output with the following changes: "
    pscale deploy-request diff "$DB_NAME" "$output" --org "$ORG_NAME"
    echo "Do you want to deploy this request? [y/n]"
    read answer
    if [ "$answer" == "y" ]; then
        pscale deploy-request deploy "$DB_NAME" $output --org "$ORG_NAME"
        # if command returns non-zero exit code then error
        if [ $? -ne 0 ]; then
            echo "Error: pscale deploy-request deploy returned non-zero exit code"
            exit 4
        fi
        wait_for_deploy_request_merged 9 "$DB_NAME" "$output" "$ORG_NAME" 60
        if [ $? -ne 0 ]; then
            echo "Error: wait-for-deploy-request-merged returned non-zero exit code"
            exit 5
        fi
    else
        echo "Aborting."
        exit 1
    fi
else
    echo "No open deployment request found: $raw_output"
    exit 3
fi