# GCP + Terraform

PROJECT_ID = code-parce
SERVICE_ACCOUNT = example@code-parce.iam.gserviceaccount.com
FILE_PATH = exampleo.json

### Creacion de un service account para los deployments en el CI/CD

```bash
#Crear un Service Account (se debe hacer con la cuenta owner)
gcloud iam service-accounts create terraform-ci --display-name "Terraform CI/CD service account"

#Asignarle permisos
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT"  --role="roles/editor"

# Crear y descargar la clave JSON
gcloud iam service-accounts keys create $FILE_PATH --iam-account=$SERVICE_ACCOUNT

#Configurar el CI/CD
export GOOGLE_APPLICATION_CREDENTIALS="$FILE_PAT"

gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"
```

### Comando terraform basicos

```bash 
export BACKEND_NAME='tfstate/func-app-get-data'

terraform init -backend-config="prefix=${BACKEND_NAME}" -reconfigure

terraform console

terraform plan

terraform apply  -lock-timeout=1m -auto-approve

terraform destroy 
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

## Servicios gratuitos

| Categoría                 | Servicio                | Límite gratuito mensual                                                                        | Notas importantes                                |
| ------------------------- | ----------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| **Compute**               | Compute Engine          | 1 VM f1-micro (us-central1 o us-east1), 30 GB HDD, 1 GB salida red                             | Solo en regiones de EE. UU., micro VM compartida |
|                           | Cloud Functions         | 2M invocaciones, 400k GB-segundos, 200k GHz-segundos CPU, 5 GB salida red                      | Funciones de hasta 256 MB RAM                    |
|                           | App Engine              | 28 horas de instancia diarias, 1 GB de almacenamiento, 5 GB salida red                         | Solo entornos estándar, ciertas regiones         |
| **Storage**               | Cloud Storage           | 5 GB almacenamiento regional, 5k operaciones clase A, 50k operaciones clase B, 1 GB salida red | Aplica a buckets regionales                      |
| **Bases de datos**        | Firestore (modo nativo) | 50k lecturas, 50k escrituras, 50k eliminaciones, 1 GB almacenamiento                           | No aplica a Firestore en modo Datastore          |
|                           | Firebase Realtime DB    | 1 GB almacenamiento, 50k lecturas, 50k escrituras                                              | Incluye ancho de banda limitado                  |
| **Networking**            | Salida de red           | 1 GB de salida desde América del Norte                                                         | Solo para tráfico saliente                       |
|                           | Cloud Load Balancing    | Limitado                                                                                       | Se incluyen reglas básicas de balanceo           |
| **Pub/Sub**               | Pub/Sub                 | 10 GB de mensajes publicados y entregados                                                      | Incluye latencia y throughput limitados          |
| **Machine Learning / AI** | AI Platform Notebooks   | 0.6 vCPU, 0.5 GB RAM                                                                           | Solo notebooks pequeñas                          |
|                           | Vision API              | 1,000 unidades de procesamiento de imágenes                                                    | Límite pequeño, solo pruebas                     |
|                           | Translation API         | 500,000 caracteres                                                                             | Traducción básica                                |
| **Other**                 | Cloud Build             | 120 min de build por mes                                                                       | Límites de compilación de contenedores           |
|                           | Secret Manager          | 10 secretos, 10k accesos                                                                       | Incluye versiones de secretos                    |

---
