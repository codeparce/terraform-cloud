
# Subir microservicios a azure con CONTINER APP

### Regla de oro DevOps

1 SP por pipeline / propósito, no uno gigante para todo.

## .env test

```bash 
export GITHUB_REF_NAME="main"
export GITHUB_REPOSITORY="codeparce-registry"
export APP_ID=
export OBJ_ID=

set -a
source .env
set +a

set | grep '^TF'
```

## Azure

### Obtener el OBJECT ID del service account

```bash 
az ad sp show --id $APP_ID --query id -o tsv
```

## Terra

```bash 
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure

terraform plan

terraform apply  -lock-timeout=1m -auto-approve

terraform destroy
```


