
# Set DB_NAME unless it is already set
export DB_NAME=${DB_NAME:-example-db-${GITHUB_USER}}
echo "Using DB name ${DB_NAME}"

# set org name to first org the user has access to unless it is already set in ORG_NAME
if [ -z "${ORG_NAME}" ]; then
    export ORG_NAME=`pscale org list --format json | jq -r ".[0].name"`
    # check exit code and name of the org
    if [ $? -ne 0 ] || [ -z "${ORG_NAME}" ]; then
        echo "Error: Failed to get PlanetScale org name, please set ORG_NAME explicitly or use Web based SSO, service tokens do not allow to list orgs."
        exit 1
    fi
fi
echo "Using org name ${ORG_NAME}"

export BRANCH_NAME=${BRANCH_NAME:-"main"}
echo "Using branch name ${BRANCH_NAME}"

# if CI variable ist set
if [ -n "$CI" ]; then
    echo "::set-output name=DB_NAME::$DB_NAME"
    echo "::set-output name=ORG_NAME::$ORG_NAME"
    echo "::set-output name=BRANCH_NAME::$BRANCH_NAME"
fi
