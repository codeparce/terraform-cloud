# Terraform Cloud

[ Terraform Azure ](./aws/README.MD)

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

## MAP + COST + SECURITY 

[Herramienta para graficar infra Automaticamente](https://app.cloudcraft.co/)


### Infracost (FIX : se pone lento al utilziar el comando)

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

### Trivy Sercurity

[Herramienta para escaneos de vulnerabilidades](https://trivy.dev/docs/latest/guide/target/filesystem/)

```bash
# crea el plan en un archivo
terraform plan --out tfplan.binary

# valida vulnerabilidades del plan hecho
trivy config tfplan.binary

# apply
terraform apply 
```