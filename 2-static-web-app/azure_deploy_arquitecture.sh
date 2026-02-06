#!/usr/bin/env bash
set -euo pipefail

echo "Azure Login CLI"

ls -la ./

az login --service-principal \
  -u "$ARM_CLIENT_ID" \
  -p "$ARM_CLIENT_SECRET" \
  --tenant "$ARM_TENANT_ID"


echo "Set the subscription"

az account set --subscription "$ARM_SUBSCRIPTION_ID"

echo "Set environment"

source .env 


echo "Environment variables loaded"

echo "TF_VAR_resource_group_name : $TF_VAR_resource_group_name"  
echo "TF_VAR_location : $TF_VAR_location"  
echo "TF_VAR_static_app_name : $TF_VAR_static_app_name"  