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

  default_route_table_name    = "NN"
  default_security_group_name = "NN"
  default_network_acl_name    = "NN"

  # Cobra, desabilitar
  enable_nat_gateway = true
  single_nat_gateway = true # solo un NAT Gateway para la VPC


  # NACL reglas dedicadas para la subred pública
  public_dedicated_network_acl = true

  public_inbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "protocol" : "all",
      "rule_action" : "allow",
      "rule_number" : 100,}
 ]

  public_outbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "protocol" : "all",
      "rule_action" : "allow",
      "rule_number" : 1000,
    }
  ]

  tags = {
    tf  = "true"
    env = "test"
  }
}
