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

echo "Setting organizational policy configuration..."
PROJECT_NUMBER=$(gcloud projects list --filter="$(gcloud config get-value project)" --format="value(PROJECT_NUMBER)")

sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/requireOsLogin.yaml
sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/allowedPolicyMemberDomains.yaml
sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/requireShieldedVm.yaml
sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/vmExternalIpAccess.yaml

gcloud org-policies set-policy ./policies/requireOsLogin.yaml --project=$PROJECT_ID
gcloud org-policies set-policy ./policies/allowedPolicyMemberDomains.yaml --project=$PROJECT_ID
gcloud org-policies set-policy ./policies/requireShieldedVm.yaml --project=$PROJECT_ID
gcloud org-policies set-policy ./policies/vmExternalIpAccess.yaml --project=$PROJECT_ID

echo "Create network, if it doesn't exist..."
gcloud services enable compute.googleapis.com
gcloud compute networks create default