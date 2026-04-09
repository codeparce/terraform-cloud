#!/usr/bin/env bash
set -Eeuo pipefail

source ../logs.sh

source ../utils_deploy.sh

LOG_AZ="azure-logs.log"

FILE_JSON="secret/static-web-app-json.json"

mkdir -p secret

touch $LOG_AZ $FILE_JSON

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

## -----------------------------
## 4. OBETENER SECRET LIST DE AZURE STATIC WEB APP
## -----------------------------
az staticwebapp secrets list \
--name $TF_VAR_STATIC_APP_NAME \
--resource-group $TF_VAR_RESOURCE_GROUP_NAME > $FILE_JSON

echo "✅ SUCCESS: Secrets exported to $FILE_JSON"