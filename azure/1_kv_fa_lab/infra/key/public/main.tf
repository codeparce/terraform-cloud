data "azurerm_client_config" "current" {}

##  Creacion del Key vault - publico
resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.env}-codeparce-lab"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  enable_rbac_authorization = true
  ##rbac_authorization_enabled = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  soft_delete_retention_days  = 7

  purge_protection_enabled    = false 

  sku_name = "standard"

  tags = {
    env: var.env,
    terraform: true
  }
}


# Asignación del Rol: Key Vault Secrets Officer

resource "azurerm_role_assignment" "secrets_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.user_object_id
}