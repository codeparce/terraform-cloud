
# Un Security Group sencillo para la EC2
module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  
  name        = "rds-sg"
  description = "SG para instancia RDS"
  vpc_id      = var.vpc_id

  ## Se permite el trafico solo de el SG de EC2
  ingress_rules = {
    ec2 = {
      ip_protocol = "tcp"
      from_port   = 3306
      to_port     = 3306
      referenced_security_group_id = var.ec2_sg_id
    }
  }

  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = { env = "dev" }
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "rds-db"

  # Database configuration
  engine            = "mysql"
  engine_version    = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class    = "db.t3.micro"
  
  # Credentials configuration 
  db_name  = "rdsdb"
  username = "admin"
  port     = "3306"
  manage_master_user_password = true

  # Storage configuration
  allocated_storage = 20
  storage_type          = "gp3"
  storage_encrypted     = true

  # --- CONFIGURACIÓN DE RED PRIVADA ---
  create_db_subnet_group = true
  db_subnet_group_name   = "rds-subnet-group"
  db_subnet_group_description = "Subnets privadas para RDS"

  subnet_ids             = var.subnet_ids 
  availability_zone = "us-east-1b"
  vpc_security_group_ids = [module.rds_sg.id] 
  publicly_accessible    = false 

  #Configuración orientada a costos y desarrollo
  multi_az               = false # sin réplica en otra AZ 
  skip_final_snapshot    = true  # Útil para entornos de prueba 
  deletion_protection    = false # Permite destruir el recurso con terraform destroy fácilmente

  # Mantenimiento y Respaldos económicos
  copy_tags_to_snapshot   = true

  tags = {
    env = "dev"
    Terraform   = "true"
  }
}
