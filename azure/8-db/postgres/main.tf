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

resource "azurerm_postgresql_flexible_server" "server" {
  name                = "exampleserver"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "B_Standard_B1ms" # Basic, Standard, Premium B_Gen4_1

  storage_mb = 32768
  #storage_tier          = "P4"
  backup_retention_days = 7
  zone                  = "1"

  public_network_access_enabled = true
  geo_redundant_backup_enabled  = false
  auto_grow_enabled             = true

  administrator_login    = var.SQL_USERNAME
  administrator_password = var.SQL_PASSWORD
  version                = "16"
  # high_availability {
  #   mode = "Disabled" # o "ZoneRedundant" si quieres HA
  # }
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "exampledb"
  server_id = azurerm_postgresql_flexible_server.server.id

  collation = "en_US.utf8"
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "my_ip" {
  name             = "AllowMyIP"
  server_id        = azurerm_postgresql_flexible_server.server.id
  start_ip_address = var.IP_TEST
  end_ip_address   = var.IP_TEST
}
