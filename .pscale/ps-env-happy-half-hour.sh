#!/bin/bash
export ORG_NAME="jonico"
echo "::set-output name=ORG_NAME::jonico"

export DB_NAME="matrix-demos-jonico"
echo "::set-output name=DB_NAME::matrix-demos-jonico"

export BRANCH_NAME="happy-half-hour"
echo "::set-output name=BRANCH_NAME::happy-half-hour"

export DEPLOY_REQUEST_NUMBER="3"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::3"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/3"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/3"

export BRANCH_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/happy-half-hour"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/happy-half-hour"

