#!/usr/bin/env bash
set -x

source ../logs.sh
source ../gcp_login.sh
source ../vault_env.sh

LOG_AZ="gcp-logs.log"

sudo snap install vault

vault -version


#mkdir -p secret
touch $LOG_AZ 

loginVault

getSecretJson service-account-terraform-gcp 

getSecret $GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME .env

cat .env

enviroment .env
