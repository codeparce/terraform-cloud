# outputs.tf
output "Subred-public" {
  value = module.vpc.public_subnets
}

output "Subred-private" {
  value = module.vpc.private_subnets
}
