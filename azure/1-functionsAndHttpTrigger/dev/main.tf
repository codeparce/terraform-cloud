resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "storage" {
  source              = "../modules/storage"
  name                = "stfuncdev"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  tags = {
    env = "dev"
  }
}

module "function_app" {
  source = "../modules/functions"

  name = "func-http-dev"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  storage_id          = module.storage.storage_files_id
  conection_string   = module.storage.azure_web_jobs_storage

  storage_account_name       = module.storage.name
  storage_account_access_key = module.storage.primary_access_key

  depends_on = [module.storage]
}
