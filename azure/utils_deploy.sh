#!/usr/bin/env bash

terraform_shell () { ## separar en funciones para mayor optimzacion en los jobs

    terraform init \
    -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure

    echo "✅ terraform init"

    terraform plan -out=tfplan -lock=false  2>&1 
    
    echo "✅ terraform plan"

    terraform apply -input=false tfplan  2>&1 
    #terraform apply -auto-approve -input=false 2>&1 | \
    #grep -vE '^\s*(name|value)\s*='

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
    local  ENV_FILE=$2
    local  FORMAT=$3

    doppler secrets download -p vault-codeparce -c $SECRET --no-file --format $FORMAT -t "$DOPPLER_TOKEN" > $ENV_FILE
    echo "✅ Download Secrets from Doppler to $ENV_FILE"
}


enviroment () {
    local ENV_FILE=$1
    set -a
    source $ENV_FILE
    set +a
    echo "✅ Set environment variables from $ENV_FILE"
}

get_App_Configuration_azure () {
    az appconfig kv export --name $TF_VAR_app_config_name --label $GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME --destination file --path ./config.json --format json --skip-feature --yes
    echo "✅ Configuracion descargada"
}