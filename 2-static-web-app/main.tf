data "azurerm_resource_group" "rg" {
  name     = var.RESOURCE_GROUP_NAME
}

resource "azurerm_static_web_app" "static-web-app" {
  name                = var.STATIC_APP_NAME
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.LOCATION
  sku_tier            = "Free"
  sku_size            = "Free"
}
