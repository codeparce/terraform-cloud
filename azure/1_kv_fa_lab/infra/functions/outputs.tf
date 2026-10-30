output "default_hostname" {
  value       = "https://${azurerm_linux_function_app.alfa.default_hostname}"
}