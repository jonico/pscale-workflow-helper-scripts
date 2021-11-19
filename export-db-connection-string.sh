#!/bin/bash

if [ -z "$DATABASE_URL" ] && [ -z "$MY_DB_URL" ]; then
    . use-pscale-docker-image.sh
    . authenticate-ps.sh
    unset PLANETSCALE_SERVICE_TOKEN
    . set-db-and-org-and-branch-name.sh
    . create-branch-connection-string.sh
    create-branch-connection-string "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" "$1"
    # if $2 and $3 are set, generate secret output links
    if [ -n "$2" ] && [ -n "$3" ]; then
        for i in `seq 1 $2`; do
            for j in `seq 1 $3`; do
                echo "::set-output name=dbconnection_${i}_${j}::`curl -s -X POST -d "plain&secret=$MY_DB_URL" https://shared-secrets-planetscale.herokuapp.com/`"          
            done
        done
    fi
fi