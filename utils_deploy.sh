#!/usr/bin/env bash

terraform_shell () { ## separar en funciones para mayor optimzacion en los jobs

    terraform init \
    -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure

    echo "✅ terraform init"

    terraform apply  -auto-approve

    echo "✅ terraform apply"
}

azure_login(){
  az login --service-principal \
    -u "$ARM_CLIENT_ID" \
    -p "$ARM_CLIENT_SECRET" \
    --tenant "$ARM_TENANT_ID"  > "$LOG_AZ" 2>&1

  echo "✅ Azure Login CLI"

  az account set --subscription "$ARM_SUBSCRIPTION_ID" > "$LOG_AZ" 2>&1

  echo "✅ Set the subscription"
}

get_doppler_secrets(){
    local  SECRET=$1
    local ENV_FILE=$2

    doppler secrets download -p vault-codeparce -c $SECRET --no-file --format env -t "$DOPPLER_TOKEN" > $ENV_FILE
    echo "✅ Download Secrets from Doppler to $ENV_FILE"
}


enviroment () {
    local ENV_FILE=$1
    source $ENV_FILE
    set +a
    echo "✅ Set environment variables from $ENV_FILE"
}