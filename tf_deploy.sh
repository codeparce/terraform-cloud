#!/usr/bin/env bash
terraform_shell () { ## separar en funciones para mayor optimzacion en los jobs

    terraform init \
    -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure

    echo "✅ terraform init"

    terraform apply  -auto-approve

    echo "✅ terraform apply"
}

enviroment () {
    set -a
    source .env
    set +a
    echo "✅ Set environment"
}