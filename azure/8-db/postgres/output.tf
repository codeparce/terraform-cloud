output "postgresql_flexible_server_fqdn" {
  value = azurerm_postgresql_flexible_server.server
  sensitive = true
}

output "database_name" {
  value = azurerm_postgresql_flexible_server_database.db.name
}