#!/usr/bin/env bash
 
source ../logs.sh
source ../azure_login.sh
source ../tf_deploy.sh

LOG_AZ="azure-logs.log"
FILE_JSON="secret/static-web-app-json.json"
mkdir -p secret
touch $LOG_AZ $FILE_JSON

azure_login

enviroment

terraform_shell

az staticwebapp secrets list \
--name $TF_VAR_static_app_name \
--resource-group $TF_VAR_resource_group_name > $FILE_JSON

echo "✅ SUCESS: Secrets exported to $FILE_JSON"