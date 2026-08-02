module "vpc" {
  source = "./vpc"
  #name               = "vpc-test"
  #cidr               = "10.0.0.0/16"
  #public_subnets     = ["10.0.1.0/24"]
  #private_subnets    = ["10.0.10.0/24"]
  #availability_zones = ["us-east-1a"]
}

module "ec2" {
  source = "./ec2"
  vms_confg = {
    "vm1" = { name = "vm-sis-01-test",
    subnet_id = module.vpc.subred_public_id,
    sg_id = [module.vpc.sg_id]}
  }
}


