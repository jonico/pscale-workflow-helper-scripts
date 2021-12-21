# PlanetScale pscale CLI helper scripts ([Recording from live demo at PlanetScale Happy-Half-Hour](https://youtu.be/l3oe7srRUZw?t=610))

Ever wanted to accomplish a complex database workflow with [pscale CLI](https://github.com/planetscale/cli) and needed a way to automate asynchronous operations like [database branch](https://docs.planetscale.com/concepts/branching) creation or [schema change requests](https://planetscale.com/blog/building-planetscale-with-planetscale) merges? Interested in using the PlanetScale database branching, approval and merging features directly out of your pull/merge requests?

![image](https://user-images.githubusercontent.com/1872314/144895567-85937eb8-25eb-4066-9863-8e834a108127.png)

This is a collection of helper scripts around the PlanetScale CLI to synchronously
* [wait for branch creation to be completed](.pscale/cli-helper-scripts/wait-for-branch-readiness.sh)
* [wait for deploy requests to be successfully merged](.pscale/cli-helper-scripts/wait-for-deploy-request-merged.sh) (and get an update on the current migration status)
* [DB connection string creation/parsing and extending scope of service tokens](.pscale/cli-helper-scripts/create-database.sh)
* examples on how create branches and deploy requests ([branches](.pscale/cli-helper-scripts/add-operation-column-and-index.sh), [credentials](.pscale/cli-helper-scripts/create-database.sh), [deploy requests](.pscale/cli-helper-scripts/merge-latest-open-deploy-request.sh))
* [creating one-time links](.pscale/cli-helper-scripts/create-branch-connection-string.sh) with connection info for feature branches that correspond to your preview environments
* [run pscale from a Docker container](.pscale/cli-helper-scripts/use-pscale-docker-image.sh) and still use your local config files, service tokens and port forwarding
* [delete databases](.pscale/cli-helper-scripts/remove-database.sh)

### Examples from the community how to make use of those pscale workflows

In the [issues section of this repo](https://github.com/jonico/pscale-cli-helper-scripts/issues) you will find examples how to integrate your favorite framework and CI with the pscale workflow examples provided here. If you have our own examples you like to share with the commmunity and get the chance to win some swag, please [add your example here](https://github.com/jonico/pscale-cli-helper-scripts/issues/new/choose).


## Zero-setup Action workflows included :sparkles:

In case you like to see those helper scripts in action without any further manual configuration, just 

1. [Create a copy of this repo](https://github.com/jonico/pscale-cli-helper-scripts/generate) by clicking on the green 'Use this template' button or just [here](https://github.com/jonico/pscale-cli-helper-scripts/generate). Both private and public repo visibility work.

![image](https://user-images.githubusercontent.com/1872314/141356169-d1dcc996-9e3f-41bc-b4cb-c96b5f0cb843.png)

2. Create a PlanetScale account:  If you have not done already, [sign up here](https://auth.planetscale.com/sign-up) for a PlanetScale account, you can have one database for free. Do not create a database yet though, this step will be automated as part of the first Action workflow.

3. Switch to the Actions tab in your repo

![image](https://user-images.githubusercontent.com/1872314/143506776-69faa942-475f-41d0-8667-07fd2106c06b.png)

4. [Start the workflows manually](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow), in the displayed order.

![image](https://user-images.githubusercontent.com/1872314/142615142-e60164a0-f441-47ee-b92e-ef20e22aca81.png)

5. When you run the workflows, follow the output where it will ask you to authenticate to PlanetScale by clicking the displayed links.

![image](https://user-images.githubusercontent.com/1872314/142614600-83d06471-b0bd-4c7a-81bb-d8836e547e78.png)

### Issue-Ops based workflow

The workflows covered so far have been all triggered as manual GitHub Action jobs. If you start the ["Create branch/PR for schema change"](https://github.com/jonico/pscale-cli-helper-scripts/actions/workflows/create-db-branch-and-pr-dr.yml) workflow, a pull request like [this one](https://github.com/jonico/pscale-cli-helper-scripts/pull/2) will be created that is associated with a PlanetScale deploy request and the desired schema changes. Those schema changes can then be applied by adding a `/ps-merge`comment to the pull request. This IssueOps command will also create [GitHub deployment events](https://docs.github.com/en/rest/guides/delivering-deployments), so that you could have other integrations and Action based workflows [hook into](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows#deployment) the deployment lifecycle.

![image](https://user-images.githubusercontent.com/1872314/143507761-4112d767-ed12-4353-828c-629ac83e9851.png)

You can also create a database branch and deploy request based on an [already existing Pull Request](https://github.com/jonico/pscale-cli-helper-scripts/pull/2) using `/ps-create`:
![image](https://user-images.githubusercontent.com/1872314/143734380-132bdd39-b4bc-4ec0-b1e8-79d31748542c.png)

If you like to refresh the schema information of your branch or add additional DDL statements, use `/ps-update`:

![image](https://user-images.githubusercontent.com/1872314/144099735-8e023ecf-31ef-4129-82d0-3aa91d5c9777.png)

Approvals can be done using `/ps-approve`:

![image](https://user-images.githubusercontent.com/1872314/144145346-4263e70e-4eca-4bfe-b2b3-639cca99f1bd.png)

Finally, you can delete the database branch associated with a Git branch using `/ps-delete`:

![image](https://user-images.githubusercontent.com/1872314/144534299-a62a234b-2671-467b-9ec7-1cac89f85ff6.png)

Stay tuned for updates and any feedbacks / PRs are welcome 😊

