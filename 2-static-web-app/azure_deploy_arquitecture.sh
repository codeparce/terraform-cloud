#!/usr/bin/env bash

export TF_VAR_resource_group_name
export TF_VAR_static_app_name
export TF_VAR_location

source ../logs.sh
source ./azure_login.sh

LOG_AZ="azure-logs.log"

touch $LOG_AZ 
 
source .env 

echo "✅ Set environment"

terraform init \
  -backend-config="key=${TF_VAR_static_app_name}.tfstate" -reconfigure

echo "✅ terraform init"

terraform plan -lock-timeout=1m

echo "✅ terraform plan"

terraform apply -lock-timeout=1m -auto-approve

echo "✅ terraform apply"
