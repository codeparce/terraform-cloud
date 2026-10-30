output "allec2" {
  value = module.ec2_instance.vm1
}

output "ec2_id" {
  value = module.ec2_instance.vm1.id
}


output "ec2_sg_id" {
  value = module.ec2_sg.id
}

