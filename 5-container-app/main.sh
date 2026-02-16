#!/usr/bin/env bash

source ../logs.sh
source ../azure_login.sh
source ../tf_deploy.sh

LOG_AZ="azure-logs.log"
touch $LOG_AZ 

get_envs () {

}

azure_login

enviroment 

echo "Descargando configuracion"

az appconfig kv export --name $TF_VAR_app_config_name --label ${GITHUB_REPOSITORY_NAME}-${GITHUB_REF_NAME} --destination file --path ./config.json --format json --skip-feature 
ls

terraform_shell



