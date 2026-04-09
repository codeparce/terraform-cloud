#!/usr/bin/env bash

source ../logs.sh
source ../utils_deploy.sh

LOG_AZ="azure-logs.log"

touch $LOG_AZ 

## -----------------------------
## 1. OBTENER SECRETS DE DOPPLER
## -----------------------------
get_doppler_secrets "cloud_azure" ".env.cloud" env

get_doppler_secrets $APP_ENVIRONMENT ".env" env

get_doppler_secrets $APP_ENVIRONMENT "config.json" json


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
