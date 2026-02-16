# Rosource grup 

esto ayudara a separar mejor los ambientes y no crear grupos por cada app

si no cetralizarlos por main, dev , test etc.

Se puede utilizar el servicio que se quiere agrupar o que tipo de appa es como(front, ms , etc)

```bash
export APP_ID=
export OBJCT_ID=
export AZURE_SERVICE=vault
export GITHUB_REPOSITORY=codeparce
export GITHUB_REF_NAME=main


set -a
source .env
set +a

set | grep '^TF'

## Obtener el objetener el Object ID
az ad sp show --id $APP_ID --query id -o tsv

az role assignment create  --assignee $APP_ID --role "User Access Administrator"  --scope $AZURE_SERVICE

az role assignment create --assignee $APP_ID --role "Key Vault Administrator" --scope $AZURE_SERVICE

$ az keyvault secret show --vault-name $AZURE_SERVICE \
  --name  $APP_ID \
  --query value \
  -o tsv
  
```





```bash
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}-${AZURE_SERVICE}.tfstate" -reconfigure

terraform apply -auto-approve
```
