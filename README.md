# PlanetScale Workflow Helper scripts 

📺 [Recording from live demo at PlanetScale Happy-Half-Hour](https://youtu.be/l3oe7srRUZw?t=610)

📺[Longer talk at WeAreDevelopers DevOps Day](https://www.youtube.com/watch?v=ojyZ2KwiXPo&t=10786s)

This is a collection of GitHub Workflows and CI/CD helper scripts around [PlanetScale's database branching workflows](https://docs.planetscale.com/concepts/branching) to
* [attach, create, update, approve, merge and delete](#issue-ops-based-workflows) PlanetScale branches and deploy requests directly from your Pull Requests
* [wait for branch creation to be completed](.pscale/cli-helper-scripts/wait-for-branch-readiness.sh)
* [wait for deploy requests to be successfully merged](.pscale/cli-helper-scripts/wait-for-deploy-request-merged.sh) (and get an update on the current migration status)
* [DB connection string creation/parsing and extending scope of service tokens](.pscale/cli-helper-scripts/create-database.sh)
* examples on how to create branches and deploy requests ([branches](.pscale/cli-helper-scripts/add-operation-column-and-index.sh), [credentials](.pscale/cli-helper-scripts/create-database.sh), [deploy requests](.pscale/cli-helper-scripts/merge-latest-open-deploy-request.sh)) in any CI/CD environment
* [creating one-time links](.pscale/cli-helper-scripts/create-branch-connection-string.sh) with connection info for feature branches that correspond to your preview environments
* [run pscale from a Docker container](.pscale/cli-helper-scripts/use-pscale-docker-image.sh) and still use your local config files, service tokens and port forwarding
* [delete databases](.pscale/cli-helper-scripts/remove-database.sh)

### IssueOps Example

![image](https://user-images.githubusercontent.com/1872314/149749143-16a484ec-7ebf-41e3-9d93-c81c24876b1e.png)
([example PR](https://github.com/jonico/pscale-cli-helper-scripts/pull/11))

## Issue-Ops based workflows

([GitHub Actions workflow source](.github/workflows/issue-ops-ps-commands.yml))

### Installation

To test out the IssueOps commands, either work on a [copy of this repo](https://github.com/jonico/pscale-cli-helper-scripts/generate) or run the following command in the root directory of your GitHub repo's workspace and follow the suggestions of the script:

```bash
curl https://raw.githubusercontent.com/jonico/pscale-workflow-helper-scripts/main/install.sh | bash
```

### /ps-create: Create PlanetScale Deploy Request from your PR

You can create a database branch and deploy request in an [already existing Pull Request](https://github.com/jonico/pscale-cli-helper-scripts/pull/2) using `/ps-create`:
![image](https://user-images.githubusercontent.com/1872314/143734380-132bdd39-b4bc-4ec0-b1e8-79d31748542c.png)

See [configuration section](#configuration) for an explanation of the environment variables to set to specify a PlanetScale org and database different from the default settings.

### /ps-attach: Attach existing PlanetScale branch or Deploy Request to your PR

If the PlanetScale deploy request or database branch and your pull request both exist already, you can use the `/ps-attach` command, followed by the PlanetScale URL to your branch/DR:

![image](https://user-images.githubusercontent.com/1872314/149749143-16a484ec-7ebf-41e3-9d93-c81c24876b1e.png)

### /ps-update: Refresh schema info in your PR from your attached Deploy Request

If you like to refresh the schema information of your branch or add additional DDL statements, use `/ps-update`:

![image](https://user-images.githubusercontent.com/1872314/144099735-8e023ecf-31ef-4129-82d0-3aa91d5c9777.png)

### /ps-approve: Approve Deploy Request from your PR

Approvals can be done using `/ps-approve`:

![image](https://user-images.githubusercontent.com/1872314/144145346-4263e70e-4eca-4bfe-b2b3-639cca99f1bd.png)

### /ps-merge: Merge Deploy Request attached to your PR

Schema changes in attached deploy requests can then be applied to production by adding a `/ps-merge` comment to the pull request. This IssueOps command will also create [GitHub deployment events](https://docs.github.com/en/rest/guides/delivering-deployments), so that you could have other integrations and Action based workflows [hook into](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows#deployment) the deployment lifecycle.

![image](https://user-images.githubusercontent.com/1872314/143507761-4112d767-ed12-4353-828c-629ac83e9851.png)

### /ps-delete: Delete PlanetScale branch attached to your PR

Finally, you can delete the database branch associated with a Git branch using `/ps-delete`:

![image](https://user-images.githubusercontent.com/1872314/144534299-a62a234b-2671-467b-9ec7-1cac89f85ff6.png)

Stay tuned for updates and any feedbacks / PRs are welcome 😊

## Zero-setup Action workflows included :sparkles:

In case you like to see those helper scripts in action without any further manual configuration, just 

1. [Create a copy of this repo](https://github.com/jonico/pscale-cli-helper-scripts/generate) by clicking on the green 'Use this template' button or just [here](https://github.com/jonico/pscale-cli-helper-scripts/generate). Both private and public repo visibility work.

![image](https://user-images.githubusercontent.com/1872314/141356169-d1dcc996-9e3f-41bc-b4cb-c96b5f0cb843.png)

2. Create a PlanetScale account:  If you have not done already, [sign up here](https://auth.planetscale.com/sign-up) for a PlanetScale account, you can have one database for free. Do not create a database yet though, this step will be automated as part of the first Action workflow.

3. Switch to the Actions tab in your repo

![image](https://user-images.githubusercontent.com/1872314/143506776-69faa942-475f-41d0-8667-07fd2106c06b.png)

4. [Start the workflows manually](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow), in the displayed order.

![image](https://user-images.githubusercontent.com/1872314/142615142-e60164a0-f441-47ee-b92e-ef20e22aca81.png)

See [configuration section](#configuration) for an explanation of the environment variables to set to specify a PlanetScale org and database different from the default settings.

5. When you run the workflows, follow the output where it will ask you to authenticate to PlanetScale by clicking the displayed links.

![image](https://user-images.githubusercontent.com/1872314/142614600-83d06471-b0bd-4c7a-81bb-d8836e547e78.png)

If you start the ["Create branch/PR for schema change"](https://github.com/jonico/pscale-cli-helper-scripts/actions/workflows/create-db-branch-and-pr-dr.yml) workflow, a pull request like [this one](https://github.com/jonico/pscale-cli-helper-scripts/pull/2) will be created that is associated with a PlanetScale deploy request and the desired schema changes.

![image](https://user-images.githubusercontent.com/1872314/144895567-85937eb8-25eb-4066-9863-8e834a108127.png)

If you like to install the workflows in your own repository, follow the [installation steps](#installation).

## Configuration

All scripts and IssueOps command in this repo have been designed to run successfully even if [zero configuration](#zero-setup-action-workflows-included-sparkles) was provided. If the defaut values do not fit your you, or you do not like to always authorize every action with the Web UI, here are the environment variables you can override in your CI/CD or set as [GitHub secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) for your GitHub Action workflows to override default behavior.

### DB_NAME

***DB_NAME*** is name of your PlanetScale database. Unless you [attach](#ps-attach-attach-existing-planetscale-branch-or-deploy-request-to-your-pr) a specific branch or deploy request to your PR, it defaults to `example-db-<yourgithubaccount>`. If you rather like to change the source for the default DB name, it would be [this file](.pscale/cli-helper-scripts/set-db-and-org-and-branch-name.sh).

### ORG_NAME

***ORG_NAME*** is name of your PlanetScale organization. Unless you [attach](#ps-attach-attach-existing-planetscale-branch-or-deploy-request-to-your-pr) a specific branch or deploy request to your PR, it defaults to the first PlanetScale org you joined with your account. If you rather like to change the source for the default DB name, it would be [this file](.pscale/cli-helper-scripts/set-db-and-org-and-branch-name.sh).

### PLANETSCALE_SERVICE_TOKEN_ID and PLANETSCALE_SERVICE_TOKEN

If you do not like to authorize actions by clicking on authorization links in the browser, you can [create a PlanetScale service token](https://docs.planetscale.com/reference/service-tokens#create-service-tokens-using-the-planetscale-ui). Don't forget to set the [proper scopes](https://docs.planetscale.com/reference/service-tokens#add-database-access-permissions) for the database operations you like to automate.

**Note:** While service tokens can be used to work with existing databases, there is currently no scope to create new databases. This is why the scripts / workflows to create entirely new databses will always prompt you to authenticate via the Web UI.

### CI - Runnning in CI

GitHub Actions and many other CI/CD platforms set the **CI** variable to **true** when they run a script. The helper scripts in the [.pscale/cli-helper-scripts/ directory](.pscale/cli-helper-scripts/) will only prompt for interactive user input if the **CI** variable is not set. In CI mode, it will output additional [workflow commands](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions) to standard out to enable communication between GitHub Action workflow steps. If you are using a different CI/CD platform than GitHub Actions, you can ignore all lines starting with "::".

### Initial table

When you create a bew database from scratch, a default table called `pixel_matrix` will be created. If you like to change this behavior, modify [this file](.pscale/cli-helper-scripts/create-database.sh).
