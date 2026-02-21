#!/usr/bin/env bash
terraform_shell () {
    terraform init -backend-config="prefix=${BACKEND_NAME}" -reconfigure

    echo "✅ terraform init"

    terraform apply -auto-approve

    echo "✅ terraform apply"
}

