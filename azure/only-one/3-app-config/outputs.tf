output "app_configuration_id" {
  description = "ID del Azure App Configuration"
  value       = azurerm_app_configuration.appconf.id
}

output "app_configuration_name" {
  description = "Nombre del Azure App Configuration"
  value       = azurerm_app_configuration.appconf.name
}

output "app_configuration_endpoint" {
  description = "Endpoint público del Azure App Configuration"
  value       = azurerm_app_configuration.appconf.endpoint
}
