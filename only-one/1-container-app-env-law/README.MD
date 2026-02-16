
# Infra de Ambientes de contenedores

Esto crea la infra estructura base en donde van a correr los contenedores, es un recurso compartido para diferentes apps

```bash 
Tener en cuenta esta regla 
✔️ 1 Container App Environment (por anmbiente)
✔️ 1 Log Analytics Workspace (por anmbiente)
✔️ N Container Apps
```

## .env test

```bash 
export AZURE_SERVICE=environment
export GITHUB_REPOSITORY=codeparce
export GITHUB_REF_NAME=main

set -a
source .env
set +a

set | grep '^TF'
```

## Azure

NOTA: para este servicio es necesario activar lo siguiente

```bash 
az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights
```

```bash 
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}-${AZURE_SERVICE}.tfstate" -reconfigure

terraform plan

terraform apply   -auto-approve
```
