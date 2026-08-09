resource "aws_key_pair" "main" {
  key_name   = "pc-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = var.vms_confg
  name = each.value.name
  instance_type = "t3.micro"
  monitoring    = true

  # SSh key to connect to the instance
  key_name      = aws_key_pair.main.key_name

  ## VPC - subnet
  subnet_id     = each.value.subnet_id
  create_eip = true # en caso de que se necesite una ip publica que no cambie, se puede crear un EIP y asociarlo a la instancia

  ## Security grups
  create_security_group = false
  vpc_security_group_ids  = each.value.sg_ec2_id

  # Associate public IP address
  associate_public_ip_address = true
  
  

  tags = {
    Terraform   = "true"
    env = "dev"
  }
}
