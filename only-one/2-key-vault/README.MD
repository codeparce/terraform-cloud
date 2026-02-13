# Rosource grup 

esto ayudara a separar mejor los ambientes y no crear grupos por cada app

si no cetralizarlos por main, dev , test etc.

Se puede utilizar el servicio que se quiere agrupar o que tipo de appa es como(front, ms , etc)

```bash
export AZURE_SERVICE=vault
export GITHUB_REPOSITORY=codeparce
export GITHUB_REF_NAME=main


set -a
source .env
set +a

set | grep '^TF'
```


```bash
terraform init -backend-config="key=${GITHUB_REPOSITORY}-${GITHUB_REF_NAME}-${AZURE_SERVICE}.tfstate" -reconfigure

terraform apply -auto-approve
```
