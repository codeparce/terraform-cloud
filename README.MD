# Terraform Cloud

[ Terraform AWS ](./aws/README.MD)

[ Terraform Azure ](./azure/README.MD)

[ Terraform GCP ](./gcp/README.MD)

### Comando terraform basicos

```bash 
terraform init

terraform console

terraform plan

terraform apply 

terraform destroy 
```

## MAP + COST

[Herramienta para graficar infra Automaticamente](https://app.cloudcraft.co/)


[Herramienta para monitoriar los costos](https://dashboard.infracost.io/)

```bash
# login para dashboard
infracost auth login

# Ejecutamos el plan
terraform plan -out tfplan.binary
terraform show -json tfplan.binary > plan.json

infracost scan plan.json

## Mas detalles 
infracost inspect --top 10 
infracost inspect --failing
```
