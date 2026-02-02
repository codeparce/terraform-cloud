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
      node_version = "20"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    #AzureWebJobsStorage      = azurerm_storage_account.storage.primary_connection_string
    FUNCTIONS_WORKER_RUNTIME = "node"
  }
}


# ------------------------
# Azure Function Rol
# ------------------------

#resource "azurerm_role_assignment" "func_storage_blob" {
#  scope                = var.storage_id
#  role_definition_name = "Storage Blob Data Contributor"
#  principal_id         = azurerm_linux_function_app.alfa.identity[0].principal_id
#}
