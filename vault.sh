#!/usr/bin/env bash

sudo snap install vault


loginVault(){
    vault login -method=userpass username=$VAULT_USER password=$VAULT_PASS > "$LOG_GCP" 2>&1
    echo "✅ Login vault"
}

getSecret(){
    vault kv get -format=json secret/"$1"   | jq -r '.data.data | to_entries[] | "\(.key)=\(.value)"' > $2
    echo "✅ get secret vault"
    cat $2
    echo "---------- 🔎 Validate enviroments ----------"
}


getSecretJson(){
    vault kv get -format=json secret/"$1"  > key.json
    echo "✅ get service account"
    cat key.json
}

enviroment () {
    set -a
    source $1
    set +a
    echo "✅ Set environment"
}