#!/usr/bin/env bash

vault login $VAULT_TOKEN

vault kv get -format=json secret/$GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME   | jq -r '.data.data | to_entries[] | "\(.key)=\(.value)"' > .env