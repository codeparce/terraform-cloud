# Config app service

Para manejo de configuraciones generales en las aplicaciones, solo se crea uno por ambiente

```bash
export AZURE_SERVICE=config-app
export GITHUB_REPOSITORY=api-test-devops
export GITHUB_REF_NAME=main


set -a
source .env
set +a

set | grep '^TF'
```

## Para exportar e importar configuraciones

```bash

az appconfig kv import --name $TF_VAR_app_config_name --source file --path ./config.json --format json  --label ${GITHUB_REPOSITORY}-${GITHUB_REF_NAME} --content-type application/json


az appconfig kv export --name $TF_VAR_app_config_name --label ${GITHUB_REPOSITORY}-${GITHUB_REF_NAME} --destination file --path ./out_config.json --format json --skip-feature
```




## Terraform

```bash
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}-${AZURE_SERVICE}.tfstate" -reconfigure

terraform apply -auto-approve
```
