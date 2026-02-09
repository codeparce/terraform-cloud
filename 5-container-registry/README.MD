
# Subir microservicios a azure con CONTINER APP

### Regla de oro DevOps

1 SP por pipeline / propósito, no uno gigante para todo.

## .env test

```bash 
export GITHUB_REF_NAME="main"
export GITHUB_REPOSITORY="codeparce-registry"
export OBJ_ID="62622-15615xx-xsaxas-asd"
set -a
source .env
set +a

set | grep '^TF'
```

## Azure


```bash 
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure

terraform plan

terraform apply  -lock-timeout=1m -auto-approve
```


