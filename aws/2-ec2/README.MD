
# Conectar con SSM a un EC2

- Es la forma mas segura de conectarse a un EC2 sin ssh y sin abir puertos 22
- Tienes que tener habilitado egress para el puerto 443 tanto en el NACL como en el SG


##  Pasos
```bash
#Primero debes de configurar tu acces key en tu pc

# Para revisar en que cuenta estas 
aws sts get-caller-identity
 
aws ssm start-session --target <Id-instancia>
```