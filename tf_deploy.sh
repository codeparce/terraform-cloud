#!/usr/bin/env bash
terraform_shell () {

    terraform init \
    -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure

    echo "✅ terraform init"

    terraform plan -lock-timeout=0s 2>&1 | tee plan.out || true

    grep 'ID:' plan.out | awk '{print $2}' > .terraform/lock_id.txt || true

    echo "✅ terraform plan"

    terraform apply  -auto-approve

    echo "✅ terraform apply"
}

enviroment () {
    set -a
    source .env
    set +a
    echo "✅ Set environment"
}