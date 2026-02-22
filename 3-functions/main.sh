#!/usr/bin/env bash

source ../logs.sh
source ../vault.sh
source ../gcp.sh
source ../terraform.sh

LOG_GCP="gcp-logs.log"

touch $LOG_GCP 

# VAULT
loginVault

getSecret service-account-terraform-gcp  key.json

getSecret $GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME  env.tf.j

setEnvs

enviroment .env

# GCP
gcp_login

gcp_bucket

# TERRAFORM
tf_deploy