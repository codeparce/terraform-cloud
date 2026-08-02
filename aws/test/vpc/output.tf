# outputs.tf
output "subred_public_id" {
  value = module.vpc_test.public_subnets[0]
}

output "subred_public_all" {
  value = module.vpc_test.public_subnets
}

output "sg_all" {
  value = aws_security_group.ec2_sg
}

output "sg_id" {
  value = aws_security_group.ec2_sg.id
}
