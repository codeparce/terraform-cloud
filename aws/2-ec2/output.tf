output "public_ip_test" {
  value = module.ec2_instance["vm1"].public_ip
}
output "public_ip_dev" {
  value = module.ec2_instance["vm2"].public_ip
}
