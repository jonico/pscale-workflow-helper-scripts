#!/bin/bash

. use-pscale-docker-image.sh

. authenticate-ps.sh
. wait-for-branch-readiness.sh

BRANCH_NAME=${BRANCH_NAME:-"remove-operation-column-and-index"}
DDL_STATEMENTS="alter table pixel_matrix drop column operation; drop index environment_operation on pixel_matrix;"
. set-db-and-org-and-branch-name.sh

. create-db-branch.sh
create-db-branch "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" "$DDL_STATEMENTS"

. create-branch-connection-string.sh
create-branch-connection-string "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" "creds-${BRANCH_NAME}" "sharesecret"