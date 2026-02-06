#!/usr/bin/env bash
set -euo pipefail

LOG_AZ="azure-logs.log"
LOG_ERR=error.log 

touch $LOG_AZ $LOG_ERR

# Guardar TODO (stdout + stderr), append

exec >>(tee -a "$LOG_AZ") 2>> (tee -a "$LOG_ERR" >&2)

on_error() {
  echo "❌ ERROR detected. Showing logs:"
  echo "---------------------------------"
  cat $LOG_ERR
  echo "---------------------------------"
}

trap on_error ERR

echo "Azure Login CLI"

az login --service-principal \
  -u "$ARM_CLIENT_ID" \
  -p "$ARM_CLIENT_SECRET" \
  --tenant "$ARM_TENANT_ID"  > dev/null

echo "Set the subscription"

az account set --subscription "$ARM_SUBSCRIPTION_ID" > dev/null

echo "Set environment"

source .env 

#echo "Environment variables loaded"

#echo "TF_VAR_resource_group_name : $TF_VAR_resource_group_name"  
#echo "TF_VAR_location : $TF_VAR_location"  
#echo "TF_VAR_static_app_name : $TF_VAR_static_app_name"  

terraform 

#terraform init -input=false
#terraform apply -auto-approve