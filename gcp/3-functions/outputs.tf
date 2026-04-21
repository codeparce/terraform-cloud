output "function_url" {
  description = "URL pública de la Cloud Function"
  value       = google_cloudfunctions2_function.get_data.service_config[0].uri
}
