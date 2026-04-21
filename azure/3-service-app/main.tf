data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}


resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  os_type  = "Linux" # Linux or Windows
  sku_name = "F1" # FREE B1 BASIC
}


resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id


  site_config {
    application_stack {
      java_version        = "17"
      java_server         = "JAVA"
      java_server_version = "17"
    }
  }

  app_settings = {
    "WEBSITES_PORT" = "8080"
  }
}
