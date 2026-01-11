# Azure Functions + HTTP Trigger

### Comando terraform basicos

terraform init

terraform plan

terraform apply 

terraform destroy 

### Comandos extras 

az storage blob show --container-name tfstate  --name functions-dev.tfstate --account-name sttfstate7cjk72 --query "metadata.terraformlockid" -o tsv


## Desplegar funciones 

npm install -g azure-functions-core-tools@4 --unsafe-perm true


func azure functionapp publish func-http-dev


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

# O

terraform plan
```