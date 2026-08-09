module "vpc" {
  source = "./vpc"

}

module "ec2" {
  source = "./ec2"
  vms_confg = {
    "vm1" = { name = "vm-sis-01-test",
    subnet_id = module.vpc.subred_public_all[0],
    sg_ec2_id = [module.vpc.sg_ec2_id]}
  }
}

