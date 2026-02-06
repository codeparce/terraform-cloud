
#!/bin/bash

echo "Azure Login CLI"

ls -la ./

az login --service-principal --username "${{ vars.ARM_CLIENT_ID }}" \
--password "${{ vars.ARM_CLIENT_SECRET }}" --tenant "${{ vars.ARM_TENANT_ID }}"


echo "Set the subscription"

az account set --subscription "${{vars.ARM_SUBSCRIPTION_ID}}"

echo "Set environment"

source .env 


echo "Environment variables loaded"

echo "TF_VAR_resource_group_name : $TF_VAR_resource_group_name"  
echo "TF_VAR_location : $TF_VAR_location"  
echo "TF_VAR_static_app_name : $TF_VAR_static_app_name"  