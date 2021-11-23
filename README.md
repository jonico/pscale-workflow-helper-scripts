# PlanetScale pscale CLI helper scripts ([video walkthrough](https://www.youtube.com/watch?v=qAs-NNWvihQ))

Ever wanted to accomplish a complex database workflow with [pscale CLI](https://github.com/planetscale/cli) and needed a way to automate asynchronous operations like [database branch](https://docs.planetscale.com/concepts/branching) creation or [schema change requests](https://planetscale.com/blog/building-planetscale-with-planetscale) merges? This is a collection of helper scripts around the PlanetScale CLI to synchronously
* [wait for branch creation to be completed](wait-for-branch-readiness.sh)
* [wait for deploy requests to be successfully merged](wait-for-deploy-request-merged.sh) (and get an update on the current migration status)
* [DB connection string creation/parsing and extending scope of service tokens](create-database.sh)
* examples on how create branches and deploy requests ([branches](add-operation-column-and-index.sh), [credentials](create-database.sh), [deploy requests](merge-latest-open-deploy-request.sh))
* [creating one-time links](https://github.com/jonico/pscale-cli-helper-scripts/blob/main/create-branch-connection-string.sh) with connection info for feature branches that correspond to your preview environments
* [run pscale from a Docker container](https://github.com/jonico/pscale-cli-helper-scripts/blob/main/use-pscale-docker-image.sh) and still use your local config files, service tokens and port forwarding
* [delete databases](https://github.com/jonico/pscale-cli-helper-scripts/blob/main/remove-database.sh)

## Zero-setup Action workflows included :sparkles:

In case you like to see those helper scripts in action without any further manual configuration, just 

1. [Create a copy of this repo](https://github.com/jonico/pscale-cli-helper-scripts/generate) by clicking on the green 'Use this template' button or just [here](https://github.com/jonico/pscale-cli-helper-scripts/generate). Both private and public repo visibility work.

![image](https://user-images.githubusercontent.com/1872314/141356169-d1dcc996-9e3f-41bc-b4cb-c96b5f0cb843.png)

2. Create a PlanetScale account:  If you have not done already, [sign up here](https://auth.planetscale.com/sign-up) for a PlanetScale account, you can have one database for free. Do not create a database yet though, this step will be automated as part of the first Action workflow.

3. Switch to the Actions tab in your repo

![image](https://user-images.githubusercontent.com/1872314/143043812-06ff03c1-3cc3-4cc1-b150-54d7e4acdd73.png)


4. [Start the workflows manually](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow), in the displayed order.

![image](https://user-images.githubusercontent.com/1872314/142615142-e60164a0-f441-47ee-b92e-ef20e22aca81.png)

5. When you run the workflows, follow the output where it will ask you to authenticate to PlanetScale by clicking the displayed links.

![image](https://user-images.githubusercontent.com/1872314/142614600-83d06471-b0bd-4c7a-81bb-d8836e547e78.png)

