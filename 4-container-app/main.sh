#!/usr/bin/env bash

source ../logs.sh
source ../azure_login.sh
source ../tf_deploy.sh

LOG_AZ="azure-logs.log"
touch $LOG_AZ 

azure_login

enviroment 

terraform_shell