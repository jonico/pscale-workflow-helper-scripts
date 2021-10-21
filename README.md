# PlanetScale pscale CLI helper scripts

Ever wanted to automate a complex task with [pscale CLI](https://github.com/planetscale/cli) and needed a way to wait until asynchronous operations like branch creations or deploy request merges finished? This is a collection of helper scripts around the PlanetScale CLI to synchronously
* [wait for branch creation to be completed](wait-for-branch-readiness.sh)
* [wait for deploy requests to be successfully merged](wait-for-deploy-request-merged.sh) (and get an update on the current migration status)
* [connection string creation/parsing and extending scope of service tokens](create-database.sh)
* examples on how to make use of those scripts ([branches](add-operation-column-and-index.sh), [credentials](create-database.sh), [deploy requests](merge-latest-open-deploy-request.sh))
