# outputs.tf
output "vpc_id" {
  value = module.vpc_test.vpc_id
}

output "subred_public_all" {
  value = module.vpc_test.public_subnets
}

output "subred_private_all" {
  value = module.vpc_test.private_subnets
}
