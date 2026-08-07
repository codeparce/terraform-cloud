module "vpc_test" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-test"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_tags = {
    "Type" = "private"
  }
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  public_subnet_tags = {
    "Type" = "public"
  }

  # Cobra, desabilitar
  enable_nat_gateway = true
  single_nat_gateway = true

  # NACL reglas dedicadas para la subred pública
  public_dedicated_network_acl = true

  public_inbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 1024,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 1000,
      "to_port" : 65535
    },
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 80,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 2,
      "to_port" : 80
    },
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 443,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 3,
      "to_port" : 443
  }]

  public_outbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "protocol" : "all",
      "rule_action" : "allow",
      "rule_number" : 1000,
    }
  ]

  tags = {
    Terraform = "true"
    env       = "dev"
  }
}
