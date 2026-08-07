resource "aws_security_group" "sg_ecs" {

  name        = "sg_ecs"
  description = "Security Group para EC2"
  vpc_id      = module.vpc_test.vpc_id

  tags = {
    vpc = "vpc-test"
    name = "sg_ecs",
    env  = "lab"
  }
}


resource "aws_vpc_security_group_ingress_rule" "ir_ec2_http_alb" {
  security_group_id = aws_security_group.sg_ecs.id

  depends_on = [ aws_security_group.sg_alb ]

  referenced_security_group_id = aws_security_group.sg_alb.id
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}


resource "aws_vpc_security_group_egress_rule" "er_ec2_bd" {
  security_group_id = aws_security_group.sg_ecs.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "all"
}