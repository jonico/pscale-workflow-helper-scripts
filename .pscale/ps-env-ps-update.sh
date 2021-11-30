#!/bin/bash
export ORG_NAME="jonico"
echo "::set-output name=ORG_NAME::jonico"

export DB_NAME="matrix-demos-jonico"
echo "::set-output name=DB_NAME::matrix-demos-jonico"

export BRANCH_NAME="ps-update"
echo "::set-output name=BRANCH_NAME::ps-update"

export DEPLOY_REQUEST_NUMBER="3"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::3"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/3"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/3"

export BRANCH_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/ps-update"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/ps-update"

