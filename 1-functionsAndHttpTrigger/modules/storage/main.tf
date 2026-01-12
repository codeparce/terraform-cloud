# ------------------------
# Random suffix
# ------------------------
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# ------------------------
# Storage Account
# ------------------------
resource "azurerm_storage_account" "storage" {
  name                     = "${var.name}${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false

}

resource "azurerm_storage_account" "files" {
  name                     = "files${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  access_tier = "Hot"

  allow_nested_items_to_be_public = false

    blob_properties {
    versioning_enabled = false
  }

  tags = var.tags
}

resource "azurerm_storage_container" "uploads" {
  name                  = "uploads"
  storage_account_name = azurerm_storage_account.files.name
  container_access_type = "private"
}
