#!/usr/bin/env bash
 
source ../logs.sh
source ../gcp_login.sh
source ../vault_env.sh

LOG_AZ="gcp-logs.log"

#mkdir -p secret
touch $LOG_AZ 

loginVault

getSecretJson service-account-terraform-gcp 

getSecret $GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME .env

cat .env

enviroment .env
