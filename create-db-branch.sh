function create-db-branch {
    local DB_NAME=$1
    local BRANCH_NAME=$2
    local ORG_NAME=$3
    local DDL_STATEMENTS=$4

    # delete the branch if it already exists
    echo "Trying to delete branch $BRANCH_NAME if it already existed ..."
    pscale branch delete "$DB_NAME" "$BRANCH_NAME" --force --org "$ORG_NAME" 1>/dev/null
    pscale branch create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
    wait_for_branch_readiness 7 "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" 10
    if [ $? -ne 0 ]; then
        echo "Branch $BRANCH_NAME is not ready"
        exit 1
    fi
    echo "Changing schema with the following DDL statements:"
    echo $DDL_STATEMENTS
    echo "$DDL_STATEMENTS" | pscale shell "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME"
    if [ $? -ne 0 ]; then
        echo "Schema change in $BRANCH_NAME could not be created"
        exit 1
    fi
    raw_output=`pscale deploy-request create "$DB_NAME" "$BRANCH_NAME" --org "$ORG_NAME" --format json`
    if [ $? -ne 0 ]; then
        echo "Deploy request could not be created: $raw_output"
        exit 1
    fi
    deploy_request_number=`echo $raw_output | jq -r '.number'`
    echo "Check out the deploy request created at https://app.planetscale.com/${ORG_NAME}/${DB_NAME}/deploy-requests/${deploy_request_number}"
}
