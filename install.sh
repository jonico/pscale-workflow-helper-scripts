#!/bin/bash

RELEASE_VERSION=0.2
PSCALE_CLI_HELPER_SCRIPTS_NAME=pscale-workflow-helper-scripts
PSCALE_SCRIPTS_DIR=.pscale/

curl -L -o ${PSCALE_CLI_HELPER_SCRIPTS_NAME}.zip https://github.com/jonico/pscale-cli-helper-scripts/archive/refs/tags/${RELEASE_VERSION}.zip
unzip -o ${PSCALE_CLI_HELPER_SCRIPTS_NAME}.zip

# create .pscale directory
mkdir -p ${PSCALE_SCRIPTS_DIR}

# copy scripts to .pscale directory
cp -r ${PSCALE_CLI_HELPER_SCRIPTS_NAME}-${RELEASE_VERSION}/.pscale/cli-helper-scripts ${PSCALE_SCRIPTS_DIR}/

# create .github/workflows directory
mkdir -p .github/workflows

# copy workflow to .github/workflows directory
cp ${PSCALE_CLI_HELPER_SCRIPTS_NAME}-${RELEASE_VERSION}/.github/workflows/*.yml .github/workflows/

# remove zip file and extracted directory
rm ${PSCALE_CLI_HELPER_SCRIPTS_NAME}.zip
rm -rf ${PSCALE_CLI_HELPER_SCRIPTS_NAME}-${RELEASE_VERSION}

echo
echo "Successfully installed pscale-workflow-helper-scripts"
echo
echo "Please run 'git add .pscale .github/workflows' and commit changes using 'git commit -m \"Add pscale helper scripts and IssueOps workflows\"'"
echo "Then run 'git push' to push changes"







