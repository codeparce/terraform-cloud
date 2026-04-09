#!/usr/bin/env bash

get_doppler_secrets(){
    VAR SECRET=$1
    VAR ENV_FILE=$2

    doppler secrets download -p vault-codeparce -c $SECRET --no-file --format env -t "$DOPPLER_TOKEN" > $ENV_FILE
}