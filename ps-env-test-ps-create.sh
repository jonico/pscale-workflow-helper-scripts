#!/bin/bash
export ORG_NAME="jonico"
echo "::set-output name=ORG_NAME::jonico"

export DB_NAME="matrix-demos-jonico"
echo "::set-output name=DB_NAME::matrix-demos-jonico"

export BRANCH_NAME="test-ps-create"
echo "::set-output name=BRANCH_NAME::test-ps-create"

export DEPLOY_REQUEST_NUMBER="5"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::5"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/5"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/5"

export BRANCH_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/test-ps-create"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/test-ps-create"

