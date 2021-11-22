#!/bin/bash

. use-pscale-docker-image.sh
. wait-for-branch-readiness.sh

. authenticate-ps.sh

BRANCH_NAME=${BRANCH_NAME:-"add-operation-column-and-index"}
DDL_STATEMENTS="alter table pixel_matrix add column operation varchar(10) default NULL; create index environment_operation on pixel_matrix(environment, operation);" 

. set-db-and-org-and-branch-name.sh

. create-db-branch.sh
create-db-branch "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" "$DDL_STATEMENTS"

. create-branch-connection-string.sh
create-branch-connection-string "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" "creds-${BRANCH_NAME}" "sharesecret"