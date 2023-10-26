# gcloud-new-project

To create a new Google Cloud project with default organizational policies pre-set, just replace the YOUR_PROJECT_ID and YOUR_BILLING_ID below and apply the configuration.

```bash
cd tf

export PROJECT_ID="YOUR_PROJECT_ID"
export BILLING_ID="YOUR_BILLING_ID"

terraform init

terraform apply -var "project_id=PROJECT_ID" -var "billing_account=BILLING_ID" -var "project_create=true"

cd ..
```
