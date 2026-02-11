#!/usr/bin/env bash
terraform_shell () {
    echo "✅ Set environment"

    terraform init \
    -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure -lock=false

    echo "✅ terraform init"

    terraform plan -lock-timeout=1m

    echo "✅ terraform plan"

    terraform apply -lock-timeout=1m -auto-approve -lock=false

    echo "✅ terraform apply"
}

enviroment () {
    set -a
    source .env
    set +a
    echo "✅ Set environment"
}