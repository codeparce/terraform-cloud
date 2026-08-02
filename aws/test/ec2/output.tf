output "public_ip_test" {
  value = module.ec2_instance["vm1"].public_ip
}
