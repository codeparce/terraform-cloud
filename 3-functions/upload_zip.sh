#!/usr/bin/env bash

source ../logs.sh
source ../vault.sh
source ../gcp.sh

LOG_GCP="gcp-logs.log"

touch $LOG_GCP 

loginVault

getSecretJson service-account-terraform-gcp 

getSecret $GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME .env.tf

enviroment .env.tf

gcp_login

gcp_bucket