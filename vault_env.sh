#!/usr/bin/env bash

sudo snap install vault


loginVault(){
    vault login -method=userpass username=$VAULT_USER password=$VAULT_PASS
    echo "✅ Login vault"
}

getSecret(){
    vault kv get -format=json secret/"$1"   | jq -r '.data.data | to_entries[] | "\(.key)=\(.value)"' > $2
    echo "✅ get secret vault"
}


getSecretJson(){
    vault kv get -format=json secret/"$1"  > key.json
    echo "✅ get service account"
}