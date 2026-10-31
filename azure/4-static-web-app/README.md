# Subir aplicaciones estaticas a azure static web APP


## Instalar el CLI para subir archivos 

```bash
npm install -g @azure/static-web-apps-cli
```


## Proyecto

```bash
npm run build 
```

## Infraestrucutra 

```bash
source .env
terraform init

terraform apply 
```



## Deploy

```bash

az staticwebapp secrets list \
--name $TF_VAR_static_app_name \
--resource-group $TF_VAR_resource_group_name

## Se obtine el token 

swa deploy ./dist --deployment-token api-key --env production

```


## Variables para poder acceder al azure


|Variable	| Valor|
|ARM_CLIENT_ID|	appId|
|ARM_CLIENT_SECRET|	password|
|ARM_TENANT_ID|	tenant|
|ARM_SUBSCRIPTION_ID|	Id-subscriptions|

```bash
ARM_CLIENT_ID=
ARM_CLIENT_SECRET=
ARM_TENANT_ID=
ARM_SUBSCRIPTION_ID=
```

### Account contributor

az account list

az ad sp create-for-rbac --name terraform-gitlab-sp --role Contributor --scopes /subscriptions/Id-subscriptions

