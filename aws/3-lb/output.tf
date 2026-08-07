# outputs.tf
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
