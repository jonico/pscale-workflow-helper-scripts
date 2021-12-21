#!/bin/bash
export ORG_NAME="jonico"
echo "::set-output name=ORG_NAME::jonico"

export DB_NAME="matrix-demos-jonico"
echo "::set-output name=DB_NAME::matrix-demos-jonico"

export BRANCH_NAME="new-directory-structure"
echo "::set-output name=BRANCH_NAME::new-directory-structure"

export DEPLOY_REQUEST_NUMBER="2"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::2"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/2"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/deploy-requests/2"

export BRANCH_URL="https://app.planetscale.com/jonico/matrix-demos-jonico/new-directory-structure"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/jonico/matrix-demos-jonico/new-directory-structure"

