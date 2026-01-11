# ------------------------
# Service Plan (Consumption)
# ------------------------
resource "azurerm_service_plan" "asp" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption (serverless)
}

# ------------------------
# Azure Function App
# ------------------------
resource "azurerm_linux_function_app" "alfa" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  service_plan_id = azurerm_service_plan.asp.id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {
    application_stack {
      node_version = "18"
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
  }
}
