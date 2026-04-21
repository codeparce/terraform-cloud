resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = "US"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true

  # lifecycle_rule {
  #   action {
  #     type = "Delete"
  #   }
  #   condition {
  #   }
  #}

  force_destroy = false
}