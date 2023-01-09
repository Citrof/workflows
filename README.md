# Github Workflows

Automated github workfows for this organization


## Variables
The `API_TOKEN_GITHUB` needs to be set in the Secrets section of your repository options. You can retrieve the `API_TOKEN_GITHUB` here *(set the repo permissions)*.

* source_file: The file or directory to be moved. Uses the same syntax as the `rsync` command. Incude the path for any files not in the repositories root directory.
* destination_repo: The repository to place the file or directory in.
* destination_folder: [optional] The folder in the destination repository to place the file in, if not the root directory.
* user_email: The GitHub user email associated with the API token secret.
* user_name: The GitHub username associated with the API token secret.
* destination_branch: [optional] The branch of the source repo to update, if not "main" branch is used.
* destination_branch_create: [optional] A branch to be created with this commit, defaults to commiting in `destination_branch`
* commit_message: [optional] A custom commit message for the commit. Defaults to `Update from https://github.com/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}`
* use_rsync: [optional] Uses `rsync -avh` instead of `cp -R` to perform the base operation. Currently works as an experimental feature (due to lack of testing) but can speed up updates to large collections of files with many small changes by only syncing the changes and not copying the entire contents again. Please understand your use case before using this, and provide feedback as issues if needed.
