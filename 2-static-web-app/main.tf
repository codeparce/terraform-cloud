data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}

resource "azurerm_static_web_app" "static-web-app" {
  name                = var.static_app_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_tier            = "Free"
  sku_size            = "Free"
}
