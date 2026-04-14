output "container_app_url" {
  description = "URL pública de la Azure Container App"
  value       = "http://${azurerm_container_app.app.ingress[0].fqdn}"
}

output "container_app_name" {
  value = azurerm_container_app.app.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "container_app_environment_name" {
  value = data.azurerm_container_app_environment.env.name
}