module "vpc_test" {
  source = "terraform-aws-modules/vpc/aws"

  name           = "vpc-test"
  cidr           = "10.0.0.0/16"
  azs            = ["us-east-1a"]

  public_subnets = ["10.0.101.0/24"]
  public_subnet_tags = {
    "Type" = "public"
  }

  # NACL reglas dedicadas para la subred pública
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
    tf  = "true"
    env = "test"
  }
}
