resource "aws_security_group" "sg_alb" {

  name        = "sg_alb"
  description = "Security Group para el Load Balancer"
  vpc_id      = module.vpc_test.vpc_id

  tags = {
    vpc = "vpc-test"
    name = "ec2-sg",
    env  = "lab"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ir_alb_http" {
  security_group_id = aws_security_group.sg_alb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "ir_alb_https" {
  security_group_id = aws_security_group.sg_alb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}


resource "aws_vpc_security_group_egress_rule" "er_alb_instance" {
  security_group_id = aws_security_group.sg_alb.id
  cidr_ipv4 = "10.0.1.0/24"
  ip_protocol = "all"
}

resource "aws_vpc_security_group_egress_rule" "er_alb_bd" {
  security_group_id = aws_security_group.sg_alb.id
  cidr_ipv4 = "10.0.2.0/24"
  ip_protocol = "all"
}
