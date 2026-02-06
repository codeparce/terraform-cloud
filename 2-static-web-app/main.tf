resource "azurerm_resource_group" "rg-static-web-app" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_static_web_app" "static-web-app" {
  name                = substr(
    replace(lower(var.static_app_name), "/", "-"),
    0,
    60
  )
  resource_group_name = azurerm_resource_group.rg-static-web-app.name
  location            = azurerm_resource_group.rg-static-web-app.location
  sku_tier            = "Free"
  sku_size            = "Free"
}
