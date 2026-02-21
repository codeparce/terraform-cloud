#!/usr/bin/env bash

sudo snap install vault


loginVault(){
    vault login -method=userpass username=$VAULT_USER password=$VAULT_PASS > "$LOG_GCP" 2>&1
    echo "✅ Login vault"
}

getSecret(){
    vault kv get -format=json secret/"$1"  | jq -r '.data.data' > env.tf.j
    jq -r 'to_entries[] | "\(.key)=\(.value)"' env.tf.j > $2
    echo "✅ get secret vault"

    envsubst < $2 > .env
    envsubst < env.tf.j > env.json 
    echo "✅ replace envs"
    
    cat .env
    cat env.json 
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