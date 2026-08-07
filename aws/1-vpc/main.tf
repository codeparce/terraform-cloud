data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc-tf-hub"
  cidr = "10.0.0.0/16"

  azs                  = ["us-east-1a"]
  private_subnets      = ["10.0.1.0/24"]
  
  private_subnet_tags = {
    "Type" = "private"
  }
  
  public_subnets       = ["10.0.101.0/24"]
  public_subnet_tags = {
    "Type" = "public"
  }
  
  enable_dns_hostnames = true

  # para que los recursos privados, puedan salir a internet
  enable_nat_gateway = true
  
  enable_vpn_gateway = false

  manage_default_route_table    = false
  manage_default_network_acl    = false
  manage_default_security_group = false
  # para modificar las reglas de ACL predeterminadas
  # manage_default_network_acl = true
  # default_network_acl_ingress 
  # default_network_acl_egress 
  
  public_dedicated_network_acl  = true

  

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
      "cidr_block" : "${chomp(data.http.my_ip.response_body)}/32",
      "from_port" : 22,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 1,
      "to_port" : 22
    },
    {
      "cidr_block" : "${chomp(data.http.my_ip.response_body)}/32",
      "from_port" : 80,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 2,
      "to_port" : 80
    },
    {
      "cidr_block" : "${chomp(data.http.my_ip.response_body)}/32",
      "from_port" : 443,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 3,
      "to_port" : 443
  }]

  tags = {
    Terraform = "true"
    env       = "dev"
  }
}
