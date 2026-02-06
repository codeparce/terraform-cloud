#!/usr/bin/env bash

export TF_VAR_resource_group_name
export TF_VAR_static_app_name
export TF_VAR_location

source ../logs.sh

LOG_AZ="azure-logs.log"

touch $LOG_AZ 

az login --service-principal \
  -u "$ARM_CLIENT_ID" \
  -p "$ARM_CLIENT_SECRET" \
  --tenant "$ARM_TENANT_ID"  > "$LOG_AZ" 2>&1

echo "✅ Azure Login CLI"

az account set --subscription "$ARM_SUBSCRIPTION_ID" > "$LOG_AZ" 2>&1

echo "✅ Set the subscription"

source .env 

echo "✅ Set environment"
terraform force-unlock -force ab2e9bb0-79b5-9ac8-d817-118d8b4b7701 || true

terraform init \
  -backend-config="key=${TF_VAR_static_app_name}.tfstate" -reconfigure

echo "✅ terraform init"

echo "$TF_VAR_static_app_name"
echo "$TF_VAR_resource_group_name"
echo "$TF_VAR_location"

terraform plan -lock-timeout=1m

echo "✅ terraform plan"

#terraform apply -lock-timeout=1m -auto-approve

echo "✅ terraform apply"
