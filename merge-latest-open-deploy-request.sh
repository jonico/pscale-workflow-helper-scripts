#!/bin/bash

. use-pscale-docker-image.sh
. authenticate-ps.sh
. wait-for-deploy-request-merged.sh
. set-db-and-org-and-branch-name.sh

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
    # only ask for user input if CI variabe is not set
    if [ -z "$CI" ]; then
        read -p "Do you want to deploy this deployment request? [y/N] " -n 1 -r
        echo
        if ! [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Deployment request $output was not deployed."
            exit 1
        fi
    fi

    pscale deploy-request deploy "$DB_NAME" "$output" --org "$ORG_NAME"
    # check return code, if not 0 then error
    if [ $? -ne 0 ]; then
        echo "Error: pscale deploy-request deploy returned non-zero exit code $?"
        exit 1
    fi

    wait_for_deploy_request_merged 9 "$DB_NAME" "$output" "$ORG_NAME" 60
    if [ $? -ne 0 ]; then
        echo "Error: wait-for-deploy-request-merged returned non-zero exit code"
        exit 5
    else
        echo "Check out the deploy request merged at https://app.planetscale.com/${ORG_NAME}/${DB_NAME}/deploy-requests/${output}"
    fi
else
    echo "No open deployment request found: $raw_output"
    exit 3
fi
