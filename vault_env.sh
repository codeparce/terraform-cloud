#!/usr/bin/env bash

apt install vault -y

loginGcp(){
    vault login -method=userpass username=$VAULT_USER password=$VAULT_PASS
}

getSecret(){
    vault kv get -format=json secret/"$1"   | jq -r '.data.data | to_entries[] | "\(.key)=\(.value)"' > $2
}


getSecretJson(){
    vault kv get -format=json secret/"$1"  > key.json
    pwd
    ls
}