# PlanetScale pscale CLI helper scripts

Ever wanted to automate a complex task with [pscale CLI](https://github.com/planetscale/cli) and needed a way to wait until asynchronous operations like branch creations or deploy request merges finished? This is a collection of helper scripts around the PlanetScale CLI to synchronously
* [wait for branch creation to be completed](wait-for-branch-readiness.sh)
* [wait for deploy requests to be successfully merged](wait-for-deploy-request-merged.sh) (and get an update on the current migration status)
* [connection string creation/parsing and extending scope of service tokens](create-database.sh)
* examples on how to make use of those scripts ([branches](add-operation-column-and-index.sh), [credentials](create-database.sh), [deploy requests](merge-latest-open-deploy-request.sh))
* [run pscale from a Docker container](https://github.com/jonico/pscale-cli-helper-scripts/blob/main/use-pscale-docker-image.sh) and still use your local config files, service tokens and port forwarding

## Zero-setup Action workflows included :sparkles:

In case you like to see those helper scripts in action without any further manual configuration, just 

1. [Create a copy of this repo](https://github.com/jonico/pscale-cli-helper-scripts/generate) by clicking on the green 'Use this template' button or just [here](https://github.com/jonico/pscale-cli-helper-scripts/generate). Both private and public repo visibility work.

![image](https://user-images.githubusercontent.com/1872314/141356169-d1dcc996-9e3f-41bc-b4cb-c96b5f0cb843.png)

2. Create a PlanetScale account:  If you have not done already, [sign up here](https://auth.planetscale.com/sign-up) for a PlanetScale account, you can have one database for free. Do not create a database yet though, this step will be automated as part of the first Action workflow.

3. Switch to the Actions tab in your repo

![image](https://user-images.githubusercontent.com/1872314/142613710-73deb08c-9a73-4dad-b9bd-42f089b99edf.png)

4. [Start the workflows manually](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow), in the displayed order.

![image](https://user-images.githubusercontent.com/1872314/142615142-e60164a0-f441-47ee-b92e-ef20e22aca81.png)

5. When you run the workflows, follow the output where it will ask you to authenticate to PlanetScale by clicking the displayed links.

![image](https://user-images.githubusercontent.com/1872314/142614600-83d06471-b0bd-4c7a-81bb-d8836e547e78.png)

