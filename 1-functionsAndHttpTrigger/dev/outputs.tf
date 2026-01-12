
output "function_base_url" {
  description = "URL base de la Azure Function"
  value       = module.function_app.default_hostname
}


output "primary_blob_endpoint_files" {
  description = "URL base de la Azure Function"
  value       = module.storage.primary_blob_endpoint_files
}


