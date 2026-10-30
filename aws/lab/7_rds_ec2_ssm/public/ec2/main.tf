
# Un Security Group sencillo para la EC2
module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"
  
  name        = "ec2-ssm-sg"
  description = "SG para instancia EC2 con acceso SSM"
  vpc_id      = var.vpc_id

  ## Se permite todo el tráfico de salida para descargas de paquetes y actualizaciones
  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = { env = "dev" }
}

## INSTANCIA EC2
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = var.vms_confg
  name = each.value.name

  instance_type = "t3.micro" # t4g.micro  t3.micro
  monitoring    = true

  #Connect SSM role to the instance
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name

  ## VPC - subnet
  subnet_id     = var.subnet_ids[0] 
  associate_public_ip_address = true
  
  

  ## Security grups
  create_security_group = false
  vpc_security_group_ids = [module.ec2_sg.id]

  tags = {
    Terraform   = "true"
    env = "dev"
  }
}

