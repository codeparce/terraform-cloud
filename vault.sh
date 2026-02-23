#!/usr/bin/env bash

loginVault(){
    export VAULT_SKIP_VERIFY=true
    vault login -method=userpass username=$VAULT_USER password=$VAULT_PASS > "$LOG_GCP" 2> "$LOG_ERR"
    echo "✅ Login vault"
}

setEnvs(){
    envsubst < env.tf.j > env.json 
    jq -r 'to_entries[] | "\(.key)=\(.value)"' env.json  > .env
    echo "✅ replace envs"
    
    cat .env
    echo "---------- 🔎 Validate enviroments ----------"
}


getSecret(){
    vault kv get -format=json secret/"$1"  | jq -r '.data.data' > $2
    echo "✅ get secret $1"
}

enviroment () {
    set -a
    source $1
    set +a
    echo "✅ Set environment"
}