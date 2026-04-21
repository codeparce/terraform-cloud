# GCP + Terraform
```bash
set -a
source .env
set +a

terraform init -backend-config="prefix=${BACKEND_NAME}" -reconfigure
```

PROJECT_ID = code-parce  
SERVICE_ACCOUNT = example@code-parce.iam.gserviceaccount.com  
FILE_PATH = exampleo.json

## Creacion de un service account para los deployments en el CI/CD

```bash
#Crear un Service Account (se debe hacer con la cuenta owner)
gcloud iam service-accounts create terraform-ci --display-name "Terraform CI/CD service account"

#Asignarle permisos
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT"  --role="roles/editor"

# Crear y descargar la clave JSON
gcloud iam service-accounts keys create $FILE_PATH --iam-account=$SERVICE_ACCOUNT

#Configurar el CI/CD
export GOOGLE_APPLICATION_CREDENTIALS="$FILE_PAT"

#Activar la sesion con SA
gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"

## buscar que cuenta de servicio tiene la funcion
gcloud run services describe code-parce-func-main --region=us-central1 --format="value(spec.template.spec.serviceAccountName)"

    
# Darle rol de IAM para generar tokens al SA  necesario para las functions
gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACCOUNT --member="$SERVICE_ACCOUNT"  --role="roles/iam.serviceAccountTokenCreator"  --project=code-parce

# Darle rol para agregar politicas de la SA al proeycto 
gcloud projects add-iam-policy-binding --member="$SERVICE_ACCOUNT" --role="roles/run.admin" --project=code-parce

# Darle rol para agregar politicas de la SA al proeycto 
gcloud projects add-iam-policy-binding --member="$SERVICE_ACCOUNT" --role="roles/iam.serviceAccountAdmin" --project=code-parce




```

## Vault CLI
```bash
export VAULT_ADDR="https://tu-closter:8200";
export VAULT_NAMESPACE="admin"

vault login -method=userpass username=user password=

vault kv get -format=json secret/example
```

## Docker 

```docker 

docker build -t ci-tools-gcloud:latest .

# test images
docker run -it ci-tools-gcloud bash

docker tag ci-tools-gcloud:latest codeparce/ci-tools-gcloud:latest

docker push codeparce/ci-tools-gcloud:latest
```

## Terraform

```bash 
export BACKEND_NAME='tfstate/func-app-get-data'

terraform init -backend-config="prefix=${BACKEND_NAME}" -reconfigure

terraform console

terraform plan

terraform apply  -lock-timeout=1m -auto-approve

terraform destroy 
```

### Error de terrafor cuando lo cierras con Ctrl + c 

#### caso 1 si no sale el id 

```bash
#En PowerShell:

tasklist | findstr terraform

## Si sale algo → mátalo:

taskkill /F /IM terraform.exe
```

#### caso 2 si sale el id 

```bash
## Libera el lock manualmente (seguro en tu caso)
## Usa EL ID EXACTO que te muestra el error:

terraform force-unlock 85064f66-88f0-d060-7b4f-518c6b0c2816

## Vuelve a ejecutar

terraform console

```
