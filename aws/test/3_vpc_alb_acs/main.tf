module "my_vpc" {
  source = "./vpc"
  my_ip = chomp(data.http.my_ip.response_body)
}


module "my_alb" {
  source = "./alb"
  vpc_id = module.my_vpc.vpc_id
  subnets = module.my_vpc.subred_public_all
  sg_alb_id = module.my_vpc.sg_alb_id
}

module "my_ecs" {
  source = "./ecs"
}