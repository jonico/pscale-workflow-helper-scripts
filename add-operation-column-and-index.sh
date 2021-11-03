#!/bin/bash

. use-pscale-docker-image.sh
. wait-for-branch-readiness.sh

. set-db-and-org-name.sh
BRANCH_NAME=${BRANCH_NAME:-"add-operation-column-and-index"}

. authenticate-ps.sh

# delete the branch if it already exists
pscale branch delete "$DB_NAME" "$BRANCH_NAME" --force --org "$ORG_NAME"
pscale branch create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
wait_for_branch_readiness 7 "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" 10
if [ $? -ne 0 ]; then
    echo "Branch $BRANCH_NAME is not ready"
    exit 1
fi
echo "alter table pixel_matrix add column operation varchar(10) default NULL; create index environment_operation on pixel_matrix(environment, operation);" | pscale shell "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
if [ $? -ne 0 ]; then
    echo "Schema change in $BRANCH_NAME could not be created"
    exit 1
fi
pscale deploy-request create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME" 
