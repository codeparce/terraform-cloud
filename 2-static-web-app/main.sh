#!/usr/bin/main bash
 
source ../logs.sh

source ../utils_deploy.sh

LOG_AZ="azure-logs.log"

FILE_JSON="secret/static-web-app-json.json"

mkdir -p secret

touch $LOG_AZ $FILE_JSON

get_doppler_secrets "cloud_azure" ".env.cloud"

get_doppler_secrets $DOPPLER_CONFIG ".env"

enviroment ".env.cloud"

azure_login

ls

enviroment ".env"

cat .env 

terraform_shell

az staticwebapp secrets list \
--name $TF_VAR_static_app_name \
--resource-group $TF_VAR_resource_group_name > $FILE_JSON

echo "✅ SUCESS: Secrets exported to $FILE_JSON"