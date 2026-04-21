# Linux

```bash 
export GITHUB_REF_NAME="main"
export GITHUB_REPOSITORY="codeparce-registry"

set -a
source .env
set +a
```

```bash 
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}.tfstate" -reconfigure
terraform plan

terraform apply  -lock-timeout=1m -auto-approve

terraform destroy
```


# Powershell

```powershell
$env:GITHUB_REF_NAME = "main"
$env:GITHUB_REPOSITORY = "vnet-codeparce"

```

```powershell
terraform init -backend-config="key=$($env:GITHUB_REPOSITORY)-$($env:GITHUB_REF_NAME).tfstate" -reconfigure

terraform plan

terraform apply -auto-approve

terraform destroy
```

