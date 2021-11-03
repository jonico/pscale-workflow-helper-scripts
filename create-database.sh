#!/bin/bash

. set-db-and-org-name.sh
. set-db-url.sh

BRANCH_NAME=${BRANCH_NAME:-"main"}
CREDS="creds-${GITHUB_USER}"

. use-pscale-docker-image.sh
. wait-for-branch-readiness.sh

# At the moment, service tokens do not allow DB creations or prod branch promotions, hence not using the service token.
unset PLANETSCALE_SERVICE_TOKEN
. authenticate-ps.sh

pscale database create "$DB_NAME" --org "$ORG_NAME"
# check if DB creation worked
if [ $? -ne 0 ]; then
  echo "Failed to create database $DB_NAME"
  exit 1
fi

# If BRANCH_NAME was not set to main, we need to create the branch
if [ "$BRANCH_NAME" != "main" ]; then
  pscale branch create "$BRANCH_NAME" --org "$ORG_NAME"
  if [ $? -ne 0 ]; then
    echo "Failed to create branch $BRANCH_NAME"
    exit 1
  fi
fi

wait_for_branch_readiness 7 "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" 10
echo "CREATE TABLE pixel_matrix (id bigint NOT NULL AUTO_INCREMENT, environment varchar(10) NOT NULL, cell varchar(10) NOT NULL, pixel_data longtext NOT NULL, PRIMARY KEY (id), KEY environment (environment), KEY cell (cell));" | pscale shell $DB_NAME $BRANCH_NAME --org $ORG_NAME
# check whether table creation was successful
if [ $? -ne 0 ]; then
  echo "Failed to create table in branch $BRANCH_NAME for database $DB_NAME"
  exit 1
fi

pscale branch promote "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"

# grant service token permission to use the database if service token is set
if [ -n "$PLANETSCALE_SERVICE_TOKEN_NAME" ]; then
  pscale service-token add-access "$PLANETSCALE_SERVICE_TOKEN_NAME" approve_deploy_request connect_branch create_branch create_comment create_deploy_request delete_branch read_branch read_deploy_request connect_production_branch  --database "$DB_NAME" --org "$ORG_NAME"
fi

raw_output=`pscale password create "$DB_NAME" "$BRANCH_NAME" "$CREDS"  --org "$ORG_NAME" --format json`
if [ $? -ne 0 ]; then
  echo "Failed to create credentials for database $DB_NAME: $raw_output"
  exit 1
fi

MY_DB_URL=`echo "$raw_output" |  jq ". | \"mysql://\" + .id +  \":\" + .plain_text +  \"@\" + .database_branch.access_host_url + \"/${DB_NAME}\""`
echo "Please set MY_DB_URL in your personal codespaces and action secrets to ${MY_DB_URL:1:${#MY_DB_URL}-2} and grant this repo access to it."
echo "If you do not like to restart this Codespace, you would have to run the following command in your terminal:"
echo "export MY_DB_URL=${MY_DB_URL}"
