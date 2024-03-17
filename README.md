# gcloud-new-project

This template creates a new Google Cloud project with some organizational policies pre-configured (see the configuration in `./tf/main.tf`, change as needed).

You can easily run this in Google Cloud Shell by clicking on this button.



```sh
# First replace the new Project Id and existing Billing Id in the 1_env.sh file, then source it.
source 1_env.sh

# Now apply configuration to create the project
./2_apply.sh

# To destroy the project
./3_destroy.sh

```
