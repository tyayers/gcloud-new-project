# Create new Google Cloud project with Terraform

---

This tutorial helps you create a new Google Cloud project with default policies set with Terraform.

Let's get started!

---

## Prerequisites

As a prerequisite, you must have a Terraform installed (already installed in Cloud Shell) and a Google Cloud Billing Id and project create rights in a Google Cloud organization.

---

## Setup environment

To begin, edit the provided sample `1_env.sh` file, and set the environment variables there for your deployment. The `PROJECT_ID` is the new project to be created, and the `BILLING_ID` is the existing Billing Id to use for the new project.

Click <walkthrough-editor-open-file filePath="1_env.sh">here</walkthrough-editor-open-file> to open the file in the editor.

Then, source the `1_env.sh` file in the shell.

```sh
source ./1_env.sh
```
When the command has been inserted into your shell, press Enter to run the command.

---

## Apply configuration

Now we can apply the Terraform configuration.

Click <walkthrough-editor-open-file filePath="2_apply.sh">here</walkthrough-editor-open-file> to open the file in the editor.

Then, run the `2_apply.sh` file in the shell.

```sh
source ./2_apply.sh
```
When the command has been inserted into your shell, press Enter to run the command.

---

## Conclusion
<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You've successfully created a new Google Cloud project with Terraform!

<walkthrough-inline-feedback></walkthrough-inline-feedback>