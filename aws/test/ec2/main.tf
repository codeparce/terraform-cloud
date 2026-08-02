
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = var.vms_confg
  name = each.value.name
  instance_type = "t3.micro"
  monitoring    = true

  #Connect SSM role to the instance
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  
  ## VPC - subnet
  subnet_id     = each.value.subnet_id

  ## Security grups
  create_security_group = false
  vpc_security_group_ids  = each.value.sg_id

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    env = "dev"
  }
}
