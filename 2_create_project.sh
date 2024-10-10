echo "Creating project..."
gcloud projects create $PROJECT_ID

if [ -n "$BILLING_ID" ]
then
echo "Linking billing id..."
gcloud beta billing projects link $PROJECT_ID --billing-account=$BILLING_ID
fi

gcloud config set project $PROJECT_ID

gcloud services enable orgpolicy.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com

sleep 5

echo "Setting organizational policy configuration..."
PROJECT_NUMBER=$(gcloud projects list --filter="$(gcloud config get-value project)" --format="value(PROJECT_NUMBER)")
echo "Found project number $PROJECT_NUMBER"

if [ -n "$PROJECT_NUMBER" ]
then
    cp policies/requireOsLogin.yaml policies/requireOsLogin.local.yaml
    cp policies/allowedPolicyMemberDomains.yaml policies/allowedPolicyMemberDomains.local.yaml
    cp policies/requireShieldedVm.yaml policies/requireShieldedVm.local.yaml
    cp policies/vmExternalIpAccess.yaml policies/vmExternalIpAccess.local.yaml

    sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/requireOsLogin.local.yaml
    sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/allowedPolicyMemberDomains.local.yaml
    sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/requireShieldedVm.local.yaml
    sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/vmExternalIpAccess.local.yaml

    gcloud org-policies set-policy ./policies/requireOsLogin.local.yaml --project=$PROJECT_ID
    gcloud org-policies set-policy ./policies/allowedPolicyMemberDomains.local.yaml --project=$PROJECT_ID
    gcloud org-policies set-policy ./policies/requireShieldedVm.local.yaml --project=$PROJECT_ID
    gcloud org-policies set-policy ./policies/vmExternalIpAccess.local.yaml --project=$PROJECT_ID
fi

echo "Create network, if it doesn't exist..."
gcloud services enable compute.googleapis.com
gcloud compute networks create default

if [ -n "$GCP_ADD_USER" ]
then
    echo "Adding user..."
    sleep 5
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="user:$GCP_ADD_USER" \
        --role="roles/editor"
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="user:$GCP_ADD_USER" \
        --role="roles/apigee.admin"
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="user:$GCP_ADD_USER" \
        --role="roles/integrations.integrationAdmin"
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="user:$GCP_ADD_USER" \
        --role="roles/serviceusage.serviceUsageAdmin"
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="user:$GCP_ADD_USER" \
        --role="roles/compute.networkAdmin"
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="user:$GCP_ADD_USER" \
        --role="roles/cloudkms.admin"
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="user:$GCP_ADD_USER" \
        --role="roles/compute.admin"
fi
