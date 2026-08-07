resource "aws_security_group" "lb_sg" {

  name        = "lb_sg"
  description = "Security Group para el Load Balancer"
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    vpc = "vpc-test"
    name = "ec2-sg",
    env  = "lab"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ir_sg_http" {
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "${chomp(data.http.my_ip.response_body)}/32"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
resource "aws_vpc_security_group_ingress_rule" "ir_sg_https" {
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "${chomp(data.http.my_ip.response_body)}/32"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}


resource "aws_vpc_security_group_egress_rule" "er_sg_instance" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4 = "10.0.1.0/24"
  ip_protocol = "all"
}

resource "aws_vpc_security_group_egress_rule" "er_sg_bd" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4 = "10.0.2.0/24"
  ip_protocol = "all"
}
