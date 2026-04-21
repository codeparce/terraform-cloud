# Terraform Cloud

## Comandos Azure


```bash

## Obtener detalle del Axure Conteniner  registry
az acr show --name $ACR_NAME

## Login con cuenta de servicio
az login --service-principal \
-u $APP_ID \
-p $APP_PASSWORD \
--tenant $TENANT_ID

## Asiginar rol a la cuenta de servicio hacia el ACR
az role assignment list \
--assignee $APP_ID \
--scope $(az acr show --name $ACR_NAME --query id -o tsv)

# Crear rol
az role assignment create \
--assignee $APP_ID \
--role "User Access Administrator" \
--scope $(az acr show --name $ACR_NAME --query id -o tsv)
```

### Autenticacion al registry de azure

```bash
TOKEN=$(az acr login \
--name $ACR_NAME \
--expose-token \
--query accessToken \
-o tsv)

docker login $ACR_NAME.azurecr.io \
--username 00000000-0000-0000-0000-000000000000 \
--password $TOKEN
```


### Comando terraform basicos

```bash 
terraform init

terraform console

terraform plan

terraform apply 

terraform destroy 
```


### Comandos extras 

```bash 
az storage blob show --container-name tfstate  --name functions-dev.tfstate --account-name sttfstate7cjk72 --query "metadata.terraformlockid" -o tsv
```


## Error de terrafor cuando lo cierras con Ctrl + c 

### caso 1 si no sale el id 

```bash
#En PowerShell:

tasklist | findstr terraform

## Si sale algo → mátalo:

taskkill /F /IM terraform.exe
```

### caso 2 si sale el id 

```bash
## Libera el lock manualmente (seguro en tu caso)
## Usa EL ID EXACTO que te muestra el error:

terraform force-unlock 85064f66-88f0-d060-7b4f-518c6b0c2816

## Vuelve a ejecutar

terraform console
```
