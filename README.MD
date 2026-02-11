# Azure + Terraform

para colocar alias en linux

```bash
alias tf="terraform"
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

# O

terraform plan
```