output "static_web_app_url" {
  value = azurerm_static_web_app.static-web-app.default_host_name
}

output "static_web_app_name" {
  value = azurerm_static_web_app.static-web-app.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg-static-web-app.name
}