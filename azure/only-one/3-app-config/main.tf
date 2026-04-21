resource "azurerm_resource_group" "rg" { ## esto solo se crea una vez
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_configuration" "appconf" {
  name                = var.app_config_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku = "free"

  # Opcional pero recomendado
  #public_network_access = "Enabled"

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}
