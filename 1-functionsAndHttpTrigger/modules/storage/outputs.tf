output "name" {
  value = azurerm_storage_account.storage.name
}

output "primary_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
  sensitive = true
}

output "primary_blob_endpoint_files" {
  value = azurerm_storage_account.files.primary_blob_endpoint
}
