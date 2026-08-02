data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

module "vpc_test" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-test"
  cidr = "10.0.0.0/16"

  azs                  = ["us-east-1a"]
  #private_subnets      = ["10.0.1.0/24"]
  public_subnets       = ["10.0.101.0/24"]
  enable_dns_hostnames = true

  enable_nat_gateway = false
  enable_vpn_gateway = false


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
