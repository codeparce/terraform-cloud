#!/usr/bin/env bash

source ../logs.sh
source ../utils_deploy.sh

LOG_AZ="azure-logs.log"

touch $LOG_AZ 

## -----------------------------
## 1. OBTENER SECRETS DE DOPPLER
## -----------------------------
get_doppler_secrets "cloud_azure" ".env.cloud"

get_doppler_secrets $DOPPLER_CONFIG ".env"


## ----------------------------------
## 2. CONFIGURAR VARIABLES DE ENTORNO
## ----------------------------------
enviroment ".env.cloud"

enviroment ".env"

## -----------------------------
## 3. LOGIN DE AZURE Y SHELL DE TERRAFORM
## -----------------------------
azure_login

terraform_shell


get_envs () {
    az appconfig kv export --name $TF_VAR_app_config_name --label $GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME --destination file --path ./config.json --format json --skip-feature --yes
    echo "✅ Configuracion descargada"
}
