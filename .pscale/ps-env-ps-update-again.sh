#!/bin/bash
export ORG_NAME="jonico"
echo "::set-output name=ORG_NAME::jonico"

export DB_NAME="matrix-demos-jonico"
echo "::set-output name=DB_NAME::matrix-demos-jonico"

export BRANCH_NAME="ps-update-again"
echo "::set-output name=BRANCH_NAME::ps-update-again"

export DEPLOY_REQUEST_NUMBER="4"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::4"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/4"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/4"

export BRANCH_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/ps-update-again"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/ps-update-again"

