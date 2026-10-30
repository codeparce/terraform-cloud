# outputs.tf
output "alb" {
  value = module.alb.dns_name
}

output "listeners" {
  value = module.alb.listeners
}

output "target_groups" {
  value = module.alb.target_groups
}
