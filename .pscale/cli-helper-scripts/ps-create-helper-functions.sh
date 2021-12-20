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

    pscale branch create "$DB_NAME" "$BRANCH_NAME" --region us-east --org "$ORG_NAME"
    # if branch creation fails, exit with error
    if [ $? -ne 0 ]; then
        echo "Failed to create branch $BRANCH_NAME for database $DB_NAME"
        exit 1
    fi

    wait_for_branch_readiness 10 "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" 20
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
        echo "::set-output name=DEPLOY_REQUEST_NUMBER::$deploy_request_number"
        create-diff-for-ci "$DB_NAME" "$ORG_NAME" "$deploy_request_number" "$BRANCH_NAME"
    fi   
}

function create-diff-for-ci {
    local DB_NAME=$1
    local ORG_NAME=$2
    local deploy_request_number=$3 
    local BRANCH_NAME=$4
    local refresh_schema=$5

    local deploy_request="https://app.planetscale.com/${ORG_NAME}/${DB_NAME}/deploy-requests/${deploy_request_number}"
    local BRANCH_DIFF="Diff could not be generated for deploy request $deploy_request"

    # updating schema for branch
    if [ -n "$refresh_schema" ]; then
        pscale branch refresh-schema "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
    fi  

    local lines=""
    # read shell output line by line and assign to variable
    while read -r line; do
        lines="$lines\n$line"
    done < <(pscale deploy-request diff "$DB_NAME" "$deploy_request_number" --org "$ORG_NAME" --format=json | jq .[].raw)

    
    if [ $? -ne 0 ]; then
        BRANCH_DIFF="$BRANCH_DIFF : ${lines}"
    else
        BRANCH_DIFF=$lines
    fi

    if [ -n "$CI" ]; then
        BRANCH_DIFF="${BRANCH_DIFF//'"'/''}"
        BRANCH_DIFF="${BRANCH_DIFF//'%'/'%25'}"
        BRANCH_DIFF="${BRANCH_DIFF//'\n'/'%0A'}"
        BRANCH_DIFF="${BRANCH_DIFF//'\r'/'%0D'}"
        echo "::set-output name=BRANCH_DIFF::$BRANCH_DIFF"
    fi
}

function create-deployment {
    local DB_NAME=$1
    local ORG_NAME=$2
    local deploy_request_number=$3

    local deploy_request="https://app.planetscale.com/${ORG_NAME}/${DB_NAME}/deploy-requests/${deploy_request_number}"
    # if CI variable is set, export the deploy request parameters
    if [ -n "$CI" ]; then
        echo "::set-output name=DEPLOY_REQUEST_URL::$deploy_request"
        echo "::set-output name=DEPLOY_REQUEST_NUMBER::$deploy_request_number"
    fi

    echo "Going to deploy deployment request $deploy_request with the following changes: "

    pscale deploy-request diff "$DB_NAME" "$deploy_request_number" --org "$ORG_NAME"
    # only ask for user input if CI variabe is not set
    if [ -z "$CI" ]; then
        read -p "Do you want to deploy this deployment request? [y/N] " -n 1 -r
        echo
        if ! [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Deployment request $deploy_request_number was not deployed."
            exit 1
        fi
    else
        create-diff-for-ci "$DB_NAME" "$ORG_NAME" "$deploy_request_number" "$BRANCH_NAME"
    fi

    pscale deploy-request deploy "$DB_NAME" "$deploy_request_number" --org "$ORG_NAME"
    # check return code, if not 0 then error
    if [ $? -ne 0 ]; then
        echo "Error: pscale deploy-request deploy returned non-zero exit code"
        exit 1
    fi

    wait_for_deploy_request_merged 9 "$DB_NAME" "$deploy_request_number" "$ORG_NAME" 60
    if [ $? -ne 0 ]; then
        echo "Error: wait-for-deploy-request-merged returned non-zero exit code"
        echo "Check out the deploy request status at $deploy_request"
        exit 5
    else
        echo "Check out the deploy request merged at $deploy_request"
    fi

}
