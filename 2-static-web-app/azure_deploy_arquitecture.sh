#!/usr/bin/env bash

export TF_VAR_resource_group_name
export TF_VAR_static_app_name
export TF_VAR_location

source ../logs.sh

LOG_AZ="azure-logs.log"
FILE_JSON="secret/static-web-app-secrets.json"

touch $LOG_AZ $FILE_JSON
 
az login --service-principal \
  -u "$ARM_CLIENT_ID" \
  -p "$ARM_CLIENT_SECRET" \
  --tenant "$ARM_TENANT_ID"  > "$LOG_AZ" 2>&1

echo "✅ Azure Login CLI"

az account set --subscription "$ARM_SUBSCRIPTION_ID" > "$LOG_AZ" 2>&1

echo "✅ Set the subscription"

source .env 

echo "✅ Set environment"

terraform init \
  -backend-config="key=${TF_VAR_static_app_name}.tfstate" -reconfigure


echo "✅ terraform init"

terraform plan -lock-timeout=1m

echo "✅ terraform plan"

terraform apply -lock-timeout=1m -auto-approve

echo "✅ terraform apply"

NORMALIZED_NAME=$(echo "$TF_VAR_static_app_name" \
  | tr '[:upper:]' '[:lower:]' \
  | tr '/' '-' \
  | cut -c1-60)


az staticwebapp secrets list \
--name $NORMALIZED_NAME \
--resource-group $TF_VAR_resource_group_name > $FILE_JSON


ls -la 

echo "✅ SUCESS: Secrets exported to $FILE_JSON"