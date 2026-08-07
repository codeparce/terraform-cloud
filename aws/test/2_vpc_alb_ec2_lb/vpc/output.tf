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


output "sg_ec2_id" {
  value = aws_security_group.sg_ec2.id
}

output "sg_alb_id" {
  value = aws_security_group.sg_lb.id
}
