
output "function_base_url" {
  description = "URL base de la Azure Function"
  value       = module.function_app.default_hostname
}
