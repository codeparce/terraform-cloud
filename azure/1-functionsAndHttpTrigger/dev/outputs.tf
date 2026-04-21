
output "function_base_url" {
  description = "URL base de la Azure Function"
  value       = module.function_app.default_hostname
}


output "primary_blob_endpoint_files" {
  description = "URL base de la Azure Function"
  value       = module.storage.primary_blob_endpoint_files
}


output "storage_files_id" {
  description = "ID del storage "
  value       = module.storage.storage_files_id
}


output "storage_fun_id" {
  description = "ID del storage "
  value       = module.storage.storage_fun_id
}


output "azure_web_jobs_storage" {
  description = "Connection string for Azure Function App"
  value       = module.storage.azure_web_jobs_storage
  sensitive = true
}
