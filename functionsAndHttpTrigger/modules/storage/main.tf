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
