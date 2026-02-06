#!/usr/bin/env bash

LOG_AZ="azure-logs.log"

echo "Azure Login CLI"

az login --service-principal \
  -u "$ARM_CLIENT_ID" \
  -p "$ARM_CLIENT_SECRET" \
  --tenant "$ARM_TENANT_ID"  > "$LOG_AZ" 2>&1

echo "✅ Azure Login CLI"

echo "Set the subscription"

az account set --subscription "$ARM_SUBSCRIPTION_ID" > "$LOG_AZ" 2>&1

echo "✅ Set the subscription"

echo "Set environment"

source .env 

echo "✅ Set environment"


echo "terraform init and apply"

terraform 

echo "✅ terraform init and apply"

#terraform init -input=false
#terraform apply -auto-approve