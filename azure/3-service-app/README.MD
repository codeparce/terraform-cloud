
# Subir microservicios a azure APP SERVICE

## .env test

```bash 
export GITHUB_REPOSITORY="api-test-devops-example"
export GITHUB_REF_NAME="main-example"

set -a
source .env
set +a

set | grep '^TF'
```

## Proyecto 

```bash 
mvn clean package -Djar.name=app
```

## Azure

```bash 
terraform init -backend-config="key=${TF_VAR_app_name}.tfstate" -reconfigure

terraform plan

terraform apply  -lock-timeout=1m -auto-approve
```

## Deploy app

```bash 
cd ../

az webapp deploy --resource-group $TF_VAR_resource_group_name --name $TF_VAR_app_name --src-path target/app.jar --type jar
```


### NOTA 

No exite un pla gratis (F1) para este servicio, pero es buena opcion para poder desplegar aplicaciones con servidor. 

Aqui la cosa es que es basicamente es una VM que esta activa todo el tiempo y te cobra aunque la app no se use o no hay trafico

Para ahorro de costos usar mejor Azure Container Apps