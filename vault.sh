#!/usr/bin/env bash

loginVault(){
    export VAULT_SKIP_VERIFY=true
    vault login -method=userpass username=$VAULT_USER password=$VAULT_PASS > "$LOG_GCP" 2> "$LOG_ERR"
    echo "✅ Login vault"
}

getSecret(){
    vault kv get -format=json secret/"$1"  | jq -r '.data.data' > env.tf.j
    echo "✅ get secret vault"

    envsubst < env.tf.j > env.json 
    jq -r 'to_entries[] | "\(.key)=\(.value)"' env.tf.j > .env
    echo "✅ replace envs"
    
    cat .env
    echo "---------- 🔎 Validate enviroments ----------"
}


getSecretJson(){
    vault kv get -format=json secret/"$1"  | jq -r '.data.data' > key.json
    echo "✅ get service account"
}

enviroment () {
    set -a
    source $1
    set +a
    echo "✅ Set environment"
}