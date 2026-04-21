#!/usr/bin/env bash
tf_deploy () {
    terraform init -backend-config="prefix=${BACKEND_NAME}" -reconfigure

    echo "✅ terraform init"

    terraform apply -auto-approve

    echo "✅ terraform apply"
}

