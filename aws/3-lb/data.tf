data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

data "aws_lambda_function" "api" {
  function_name = "lambd-alb"
}

data "aws_vpc" "vpc" {
  id = "vpc-06d355649c974a105"
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-06d355649c974a105"]
  }
  tags = {
    Type = "public"
  }
}
    
data "aws_instance" "ec2" {
  id = "i-0f1e3c5b6a7b8c9d0"
}
