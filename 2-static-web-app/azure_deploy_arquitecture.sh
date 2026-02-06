#!/usr/bin/env bash

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

terraform 

echo "✅ terraform init and apply"

#terraform init -input=false
#terraform apply -auto-approve