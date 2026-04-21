# main.tf — Lab 1: SQL Server básica

resource "azurerm_resource_group" "rg" {
  name     = var.RG_NAME
  location = var.LOCATION

  tags = {
    name       = var.RG_NAME
    team       = split("-", var.RG_NAME)[0] # "IT"
    costcenter = split("-", var.RG_NAME)[1] # "001"
    type       = split("-", var.RG_NAME)[2] # "infra"
    env        = split("-", var.RG_NAME)[3] # "staging"
    project    = var.PROJECT_NAME
    owner      = var.OWNER
  }
}

# SQL Server lógico (el "contenedor" del motor)
resource "azurerm_mssql_server" "main" {
  name                         = "sql-${azurerm_resource_group.rg.name}" # debe ser globalmente único en Azure
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.SQL_USERNAME
  administrator_login_password = var.SQL_PASSWORD
}

resource "azurerm_mssql_database" "main" {
  name      = "sqldb-${azurerm_resource_group.rg.name}"
  server_id = azurerm_mssql_server.main.id
  sku_name  = "GP_S_Gen5_1" # Serverless Gen5, 1 vCore GP_S_Gen5_1

  max_size_gb                 = 32
  auto_pause_delay_in_minutes = 30
  min_capacity                = 0.5
}


# Regla de firewall: permite tu IP actual para conectarte desde SSMS o Azure Data Studio
resource "azurerm_mssql_firewall_rule" "my_ip" {
  name             = "allow-my-ip"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = var.IP_TEST
  end_ip_address   = var.IP_TEST
}
