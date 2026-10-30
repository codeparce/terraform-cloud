# outputs.tf
output "Subred-public" {
  value = module.vpc.public_subnets
}



## EC2 ======

output "public_ip_test" {
  value = module.ec2_instance["vm1"].public_ip
}
output "public_ip_dev" {
  value = module.ec2_instance["vm2"].public_ip
}

# ALB ======
output "sg-id" {
  value = aws_security_group.lb_sg.id
}

output "my-ip" {
  value = data.http.my_ip.response_body
}

output "my-vpc" {
  value = data.aws_vpc.vpc.id
}


output "subnet-public" {
  value = data.aws_subnets.vpc_subnets.ids
}
