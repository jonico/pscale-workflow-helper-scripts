#!/bin/bash
export ORG_NAME="planetscale"
echo "::set-output name=ORG_NAME::planetscale"

export DB_NAME="example-db-jonico"
echo "::set-output name=DB_NAME::example-db-jonico"

export BRANCH_NAME="add-operation-column-and-index"
echo "::set-output name=BRANCH_NAME::add-operation-column-and-index"

export DEPLOY_REQUEST_NUMBER="1"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::1"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/planetscale/example-db-jonico/deploy-requests/1"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/planetscale/example-db-jonico/deploy-requests/1"

export BRANCH_URL="https://app.planetscale.com/planetscale/example-db-jonico/add-operation-column-and-index"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/planetscale/example-db-jonico/add-operation-column-and-index"

