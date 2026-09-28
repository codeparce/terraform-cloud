
# Conectar con SSM a un EC2 + PortForwarding a base de datos RDS

- Es la forma mas segura de conectarse a un EC2 sin ssh y sin abir puertos 22
- Tienes que tener habilitado egress para el puerto 443 tanto en el NACL como en el SG


##  Pasos
```bash
# Primero debes de configurar tu acces key en tu pc

# Para revisar en que cuenta estas 
aws sts get-caller-identity

aws  ssm start-session --target i-0ae88b12114ade800 #<Id-instancia>

## Para bases de datos RDS
aws ssm start-session \
    --target i-0ae88b12114ade800\
    --document-name AWS-StartPortForwardingSessionToRemoteHost \
    --parameters '{"portNumber":["3306"],"localPortNumber":["3306"],"host":["rds-db.civ08uq4ondz.us-east-1.rds.amazonaws.com"]}'
```