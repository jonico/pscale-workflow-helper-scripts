# PlanetScale pscale CLI helper scripts

Ever wanted to automate a complex task with [pscale CLI](https://github.com/planetscale/cli) and needed a way to wait until asynchronous operations like branch creations or deploy request merges finished? This is a collection of helper scripts around the PlanetScale CLI to synchronously
* [wait for branch creation to be completed](wait-for-branch-readiness.sh)
* [wait for deploy requests to be successfully merged](wait-for-deploy-request-merged.sh) (and get an update on the current migration status)
* [connection string creation/parsing and extending scope of service tokens](create-database.sh)
* examples on how to make use of those scripts ([branches](add-operation-column-and-index.sh), [credentials](create-database.sh), [deploy requests](merge-latest-open-deploy-request.sh))
* [run pscale from a Docker container](https://github.com/jonico/pscale-cli-helper-scripts/blob/main/use-pscale-docker-image.sh) and still use your local config files, service tokens and port forwarding

## Zero-type Action workflows included :sparkles:

In case you like to see those helper scripts in action, just create a copy of this repo template, create a PlanetScale account and switch to the Actions tab:

![image](https://user-images.githubusercontent.com/1872314/142613710-73deb08c-9a73-4dad-b9bd-42f089b99edf.png)

When you run the workflows in sequential order, follow the Actions output where it will ask you to authenticate to PlanetScale by clicking the displayed links.
