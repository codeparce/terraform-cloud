#!/usr/bin/env bash

LOG_AZ="azure-logs.log"
touch $LOG_AZ 

source ../logs.sh
source ../azure_login.sh
source ../tf_deploy.sh

enviroment 

terraform_shell