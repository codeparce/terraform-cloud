#Private modules ============================ 
# module "vpc" {
#   source = "./private/vpc"

# }

# module "ec2" {
#   source = "./private/ec2"
#   depends_on = [module.vpc]

#   vpc_id = module.vpc.vpc_id
#   subnet_ids = module.vpc.subred_private_all
#   vms_confg = {
#     "vm1" = { name = "ec2-rds-lab"
#     }
#   }
# }


# module "rds" {
#   source = "./private/rds"
#   ec2_sg_id = module.ec2.ec2_sg_id
#   vpc_id = module.vpc.vpc_id
#   subnet_ids = module.vpc.subred_private_all
#   depends_on = [module.vpc , module.ec2]
# }

# Public modules ============================
## Se puede instalar una vpn en el ec2 para conectarse a la red privada y acceder a la rds, 
module "vpc" {
  source = "./public/vpc"
}

module "ec2" {
  source = "./public/ec2"
  depends_on = [module.vpc]

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subred_public_all
  vms_confg = {
    "vm1" = { name = "ec2-rds-lab"
    }
  }
}


module "rds" {
  source = "./public/rds"
  ec2_sg_id = module.ec2.ec2_sg_id
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subred_private_all
  depends_on = [module.vpc , module.ec2]
}