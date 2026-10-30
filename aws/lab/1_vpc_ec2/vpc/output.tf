# outputs.tf
output "vpc_id" {
  value = module.vpc_test.vpc_id
}

output "subred_public_all" {
  value = module.vpc_test.public_subnets
}

output "sg_ec2_id" {
  value = aws_security_group.sg_ec2.id
}