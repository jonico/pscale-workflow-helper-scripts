#!/bin/bash

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
BRANCH_NAME="remove-operation-column-and-index"

. use-pscale-docker-image.sh
. wait-for-branch-readiness.sh

#pscale auth login
#pscale database create $DB_NAME --org $ORG_NAME
# delete the branch if it already exists
pscale branch delete "$DB_NAME" "$BRANCH_NAME" --force --org "$ORG_NAME"
pscale branch create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
wait_for_branch_readiness 7 "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" 10
if [ $? -ne 0 ]; then
    echo "Branch $BRANCH_NAME is not ready"
    exit 1
fi
echo "alter table pixel_matrix drop column operation; drop index environment_operation on pixel_matrix;" | pscale shell "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
if [ $? -ne 0 ]; then
    echo "Schema change in $BRANCH_NAME could not be created"
    exit 1
fi
pscale deploy-request create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME" 
