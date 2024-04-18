cd tf/add-user

terraform init
terraform apply -var "project_id=$PROJECT_ID" -var "add_user=$GCP_ADD_USER"

cd ..
