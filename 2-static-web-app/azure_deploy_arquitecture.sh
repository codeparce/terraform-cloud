#!/usr/bin/env bash

export TF_VAR_resource_group_name
export TF_VAR_static_app_name
export TF_VAR_location

LOG_AZ="azure-logs.log"
FILE_JSON="secret/static-web-app-secrets.json"
mkdir -p secret
touch $LOG_AZ $FILE_JSON
 
source ../logs.sh
source ./azure_login.sh

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

echo "✅ SUCESS: Secrets exported to $FILE_JSON"