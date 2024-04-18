cd tf

terraform init
terraform apply -var "project_id=$PROJECT_ID" -var "billing_account=$BILLING_ID" -var "project_create=true" -var "add_user=$GCP_ADD_USER"

cd ..
