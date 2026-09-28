module "vpc_test" { ## salida con nat gateway + privado
  source = "terraform-aws-modules/vpc/aws"

  name           = "vpc-ec2-rds"
  cidr           = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1b"]

  public_subnets = ["10.0.101.0/24"]
  public_subnet_tags = {
    "Type" = "public"
  }

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_tags = {
    "Type" = "private"
  }

  ## Security Groups 
  default_security_group_name = "DefaultSecurityGroup"
  default_security_group_ingress = [{}]
  default_security_group_egress = [{}]

  ## NAT Gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  # NACL reglas dedicadas para la subred pública
  public_dedicated_network_acl = true

  public_inbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "rule_action" : "allow",
      "to_port" : 65535
      "from_port" : 1024, ## 32768 - 1024
      "protocol" : "tcp",
      "rule_number" : 119,
    },
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 443, 
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 121,
      "to_port" : 443
    },
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 80, 
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 122,
      "to_port" : 80
    },
    ]

  public_outbound_acl_rules = [
{
      rule_number = 119
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 121
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      "rule_number" : 122,
      "rule_action" : "allow",
      "from_port" : 80, 
      "to_port" : 80
      "protocol" : "tcp",
      "cidr_block" : "0.0.0.0/0",
    },
  ]


  tags = {
    tf  = "true"
    env = "dev"
  }

  # --- CONFIGURACIÓN DE FLOW LOGS ---
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  
  # Opcional: Define cuánto tiempo se guardan los logs (ej. 7 días para ahorrar costos)
  flow_log_cloudwatch_log_group_retention_in_days = 7

}

