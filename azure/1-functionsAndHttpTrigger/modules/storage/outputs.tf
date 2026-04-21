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


output "storage_files_id" {
  description = "ID del storage "
  value       = azurerm_storage_account.files.id
}


output "storage_fun_id" {
  description = "ID del storage "
  value       = azurerm_storage_account.storage.id
}

output "azure_web_jobs_storage" {
  description = "Connection string for Azure Function App"
  value       = azurerm_storage_account.files.primary_connection_string
  }
