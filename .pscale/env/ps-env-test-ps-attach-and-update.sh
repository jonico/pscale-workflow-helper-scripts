#!/bin/bash
export ORG_NAME="planetscale-demo"
echo "::set-output name=ORG_NAME::planetscale-demo"

export DB_NAME="matrix-demos-jonico"
echo "::set-output name=DB_NAME::matrix-demos-jonico"

export BRANCH_NAME="combined-key"
echo "::set-output name=BRANCH_NAME::combined-key"

export DEPLOY_REQUEST_NUMBER="111"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::111"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/planetscale-demo/matrix-demos-jonico/deploy-requests/111"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/planetscale-demo/matrix-demos-jonico/deploy-requests/111"

export BRANCH_URL="https://app.planetscale.com/planetscale-demo/matrix-demos-jonico/combined-key"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/planetscale-demo/matrix-demos-jonico/combined-key"

