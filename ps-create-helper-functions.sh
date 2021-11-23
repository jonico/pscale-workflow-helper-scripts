function create-db-branch {
    local DB_NAME=$1
    local BRANCH_NAME=$2
    local ORG_NAME=$3
    local recreate_branch=$4

    # delete the branch if it already exists and recreate branch is set
    if [ -n "$recreate_branch" ]; then
        echo "Trying to delete branch $BRANCH_NAME if it already existed ..."
        pscale branch delete "$DB_NAME" "$BRANCH_NAME" --force --org "$ORG_NAME" 2>/dev/null
    fi

    pscale branch create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
    # if branch creation fails, exit with error
    if [ $? -ne 0 ]; then
        echo "Failed to create branch $BRANCH_NAME for database $DB_NAME"
        exit 1
    fi

    wait_for_branch_readiness 7 "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" 10
    if [ $? -ne 0 ]; then
        echo "Branch $BRANCH_NAME is not ready"
        exit 1
    fi

    local branch_url="https://app.planetscale.com/${ORG_NAME}/${DB_NAME}/${BRANCH_NAME}"
    echo "Branch $BRANCH_NAME is ready at $branch_url"
    # if CI variable ist set, then set output variables
    if [ -n "$CI" ]; then
        echo "::set-output name=BRANCH_URL::$branch_url"
    fi
}

function create-schema-change {
    local DB_NAME=$1
    local BRANCH_NAME=$2
    local ORG_NAME=$3
    local DDL_STATEMENTS=$4

    echo "Changing schema with the following DDL statements:"
    echo $DDL_STATEMENTS
    echo "$DDL_STATEMENTS" | pscale shell "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
    if [ $? -ne 0 ]; then
        echo "Schema change in $BRANCH_NAME could not be created"
        exit 1
    fi
}


function create-deploy-request {
    local DB_NAME=$1
    local BRANCH_NAME=$2
    local ORG_NAME=$3

    local raw_output=`pscale deploy-request create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME" --format json`
    if [ $? -ne 0 ]; then
        echo "Deploy request could not be created: $raw_output"
        exit 1
    fi
    deploy_request_number=`echo $raw_output | jq -r '.number'`
    local deploy_request="https://app.planetscale.com/${ORG_NAME}/${DB_NAME}/deploy-requests/${deploy_request_number}"
    echo "Check out the deploy request created at $deploy_request"
    # if CI variable is set, export the deploy request URL
    if [ -n "$CI" ]; then
        echo "::set-output name=DEPLOY_REQUEST_URL::$deploy_request"
    fi
}
