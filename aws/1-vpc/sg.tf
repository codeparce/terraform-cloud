resource "aws_security_group" "ec2_sg" {

  name        = "ec2-sg"
  description = "Security Group para EC2"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "ec2-sg",
    env  = "lab"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ir_sg_http" {
  security_group_id = aws_security_group.ec2_sg.id

  cidr_ipv4   = "${chomp(data.http.my_ip.response_body)}/32"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
resource "aws_vpc_security_group_ingress_rule" "ir_sg_https" {
  security_group_id = aws_security_group.ec2_sg.id

  cidr_ipv4   = "${chomp(data.http.my_ip.response_body)}/32"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "ir_sg_ssh" {
  security_group_id = aws_security_group.ec2_sg.id

  cidr_ipv4   = "${chomp(data.http.my_ip.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "er_sg_efimere" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 1024
  to_port   = 65535
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "er_sg_http" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port   = 80
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "er_sg_https" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port   = 443
  ip_protocol = "tcp"
}
