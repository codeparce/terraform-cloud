#!/usr/bin/env bash
terraform_shell () {
    echo "✅ Set environment"

    terraform init -backend-config="prefix=${BACKEND_NAME}" -reconfigure

    echo "✅ terraform init"

    terraform plan -lock-timeout=1m

    echo "✅ terraform plan"

    terraform apply -lock-timeout=1m -auto-approve

    echo "✅ terraform apply"
}

enviroment () {
    set -a
    source $1
    set +a
    echo "✅ Set environment"
}