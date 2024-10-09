# gcloud-new-project

This template creates a new Google Cloud project with some organizational policies pre-configured (see policies directory for details).

You can easily run this in Google Cloud Shell.

```sh
# first copy the 1_env.sh file
cp 1_env.sh 1_env.local.sh
# change file contents to your GCP info
nano 1_env.local.sh
# source file
source 1_env.local.sh

# create project
./2_create_project.sh
```
