resource "azurerm_resource_group" "rg" {
  name     = "lab-vault-funcapp-rbac-${var.env}"
  location = "East US"
}

module "kv" {
  source = "./key/public"
  user_object_id = var.user_object_id
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  env = var.env
}


# module "funcapp" {
#   source = "./modules/functions"

#   name = "func-http-dev"

#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   storage_id          = module.storage.storage_files_id
#   conection_string   = module.storage.azure_web_jobs_storage

#   storage_account_name       = module.storage.name
#   storage_account_access_key = module.storage.primary_access_key

#   depends_on = [module.storage]
# }
