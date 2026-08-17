data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc-tf-hub"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  # private_subnets = ["10.0.1.0/24"]

  # private_subnet_tags = {
  #   "Type" = "private"
  # }

  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  public_subnet_tags = {
    "Type" = "public"
  }

  enable_dns_hostnames = true

  # para que los recursos privados, puedan salir a internet
  enable_nat_gateway = false

  # habilita la asignacion de ip automatica 
  #para las subredes publicas
  map_public_ip_on_launch = true

  enable_vpn_gateway = false


  public_dedicated_network_acl = true

  public_inbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "protocol" : "all",
      "rule_action" : "allow",
      "rule_number" : 1000,
    }     
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
    Terraform = "true"
    env       = "lab"
  }
}
