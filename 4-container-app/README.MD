
# Subir microservicios a azure con CONTINER APP

```bash 
Tener en cuenta esta regla 
✔️ 1 Container App Environment (por anmbiente)
✔️ 1 Log Analytics Workspace (por anmbiente)
✔️ N Container Apps
```

## .env test

```bash 
export GITHUB_REPOSITORY="api-example-devops"
export GITHUB_REF_NAME="m-e"
export DOCKER_ACCOUNT_NAME="jhoandorado"

set -a
source .env
set +a

set | grep '^TF'
```

## Proyecto 

```bash 
mvn clean package -Djar.name=app
```

## Docker hub

```docker

docker build -t api-example-devops:m-e .

docker tag api-example-devops:m-e jhoandorado/api-example-devops:m-e

docker push jhoandorado/api-example-devops:m-e

#optional

docker run -d -p 8080:8080 --name $TF_VAR_container_app_name  --memory "150M" --cpus "0.1"  --domainname "code.parce" $TF_VAR_container_image

```


## Azure

NOTA: para este servicio es necesario activar lo siguiente

```bash 
az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights
```

```bash 
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure

terraform plan

terraform apply  -lock-timeout=1m -auto-approve
```
