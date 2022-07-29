#!/bin/bash
export ORG_NAME="planetscale-demo"
echo "::set-output name=ORG_NAME::planetscale-demo"

export DB_NAME="harry-potter-jonico"
echo "::set-output name=DB_NAME::harry-potter-jonico"

export BRANCH_NAME="test-ps-attach-and-update"
echo "::set-output name=BRANCH_NAME::test-ps-attach-and-update"

export DEPLOY_REQUEST_NUMBER="6"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::6"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/planetscale-demo/harry-potter-jonico/deploy-requests/6"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/planetscale-demo/harry-potter-jonico/deploy-requests/6"

export BRANCH_URL="https://app.planetscale.com/planetscale-demo/harry-potter-jonico/test-ps-attach-and-update"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/planetscale-demo/harry-potter-jonico/test-ps-attach-and-update"

