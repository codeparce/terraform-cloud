# EKS

## Pre requsitos

- Instalar aws cli
- Instalar kubectl

### Crear el cluster 
 Con simples clicks en la consola, creas el cluster

- NOTA: 
  - El cluster necesita al menos dos subredes en diferentes zonas 
  - Crear la subred con [1-vpc](../1_vpc_ec2/)
    - esta infra te crea dos subredes publicas en dos zonas diferentes
  - **Importante** El cluster necesita estos 3 complementos , como minimo
      - CoreDNS 
      - kube-proxy
      - Amazon VPC CNI

### Conectar al cluster

```bash
aws eks update-kubeconfig --name cluster-codeparce --region us-east-1
## esto acatualiza el kube config de tu pc, 
## Puedes tener varios contextos

## probar 
kubectl get nodes
```
#### Comandos para contextos
```bash
# obtneer contextos
kubectl config get-contexs

## cambiar nombre contextos
kubectl config rename-contexs actual-contexto name

## usar contexto
kubectl config use-contexs name-context
```


#### Error couldn't get current server API

Este errror hace referencia de que el usuario con el que intentas ingresar no tiene permiso para gestionar el cluster

```bash
"Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials" E0814 15:32:43.043414 20340 memcache.go:265] 
"Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials" E0814 15:32:44.242474 20340 memcache.go:265] 
"Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials" E0814 15:32:45.443869 20340 memcache.go:265] 
"Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials" E0814 15:32:46.646247 20340 memcache.go:265] 
"Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials" error: You must be logged in to the server (the server has asked for the client to provide credentials)
```
### Solucion

```bash
#mostrar el usuario con el que estas logoneado
aws sts get-caller-identity

## Crear acceso de entrada al cluster
aws eks create-access-entry `
  --cluster-name cluster-codeparce  `
  --principal-arn arn:aws:iam::464453620485:user/tf-user `
  --region us-east-1

## Crear Politica de acceso admin
aws eks associate-access-policy `
  --cluster-name cluster-codeparce  `
  --principal-arn arn:aws:iam::464453620485:user/tf-user `
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy `
  --access-scope type=cluster `
  --region us-east-1
```
