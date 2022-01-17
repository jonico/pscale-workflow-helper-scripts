#!/bin/bash
export ORG_NAME="planetscale"
echo "::set-output name=ORG_NAME::planetscale"

export DB_NAME="shared-secrets-jonico"
echo "::set-output name=DB_NAME::shared-secrets-jonico"

export BRANCH_NAME="add-counter-column"
echo "::set-output name=BRANCH_NAME::add-counter-column"

export DEPLOY_REQUEST_NUMBER="2"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::2"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/planetscale/shared-secrets-jonico/deploy-requests/2"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/planetscale/shared-secrets-jonico/deploy-requests/2"

export BRANCH_URL="https://app.planetscale.com/planetscale/shared-secrets-jonico/add-counter-column"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/planetscale/shared-secrets-jonico/add-counter-column"

