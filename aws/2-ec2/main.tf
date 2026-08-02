resource "aws_key_pair" "main" {
  key_name   = "pc-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

variable "vms-confg" {
  type = map(object({
    subnet_id = string
    name      = string
  }))
  default = {
    "vm1"  = { name = "vm-sis-t01-test", subnet_id = "subnet-0a72614068e381e5a" }
    "vm2" = { name = "vm-sis-t01-dev", subnet_id = "subnet-0a5052eefd1989870" }
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = var.vms-confg

  name = each.value.name

  instance_type = "t3.micro"
  key_name      = aws_key_pair.main.key_name
  monitoring    = true
  subnet_id     = each.value.subnet_id

  create_security_group = false
  vpc_security_group_ids      = ["sg-0c8c5adbc583a59e0"]

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    env = "dev"
  }
}
