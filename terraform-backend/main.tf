resource "azurerm_resource_group" "tfstate" {
  name     = "rg-tfstatejddev"
  location = "West US 2"
}


resource "azurerm_storage_account" "tfstate" {
  name                     = "sttfstatejddev"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstatejddev"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
