# gcloud-new-project

This template creates a new Google Cloud project with some organizational policies pre-configured (see the configuration in `./tf/main.tf`, change as needed).

You can easily run this in Google Cloud Shell by clicking on this button.

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/tyayers/gcloud-new-project&cloudshell_git_branch=main&cloudshell_workspace=.&cloudshell_tutorial=docs/tutorial.md)

```sh
# First copy the 1_env.sh file
cp 1_env.sh 1_env.local.sh
# Change file contents to your GCP info, then source file
source 1_env.local.sh

# Now apply configuration to create the project
./2_apply.sh

# To destroy the project
./3_destroy.sh

```
