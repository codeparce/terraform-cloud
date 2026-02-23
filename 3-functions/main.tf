
data "google_storage_bucket" "existing_bucket" {
  name = var.bucket_name
}

locals { env_map = jsondecode(file("${path.module}/env.json")) }

resource "google_service_account_iam_member" "allow_sign_blob" {
  service_account_id = "projects/code-parce/serviceAccounts/terraform-ci@code-parce.iam.gserviceaccount.com"
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:terraform-ci@code-parce.iam.gserviceaccount.com"
}

resource "google_cloudfunctions2_function" "get_data" {
  name     = var.func_name
  location = var.region

  build_config {
    runtime     = "nodejs24"
    entry_point = "getData"

    source {
      storage_source {
        bucket = data.google_storage_bucket.existing_bucket.name
        object = "functions/${var.func_name}.zip"
      }
    }
  }

  service_config {
    available_memory      = "256M"
    timeout_seconds       = 60
    max_instance_count    = 1
    service_account_email = "terraform-ci@code-parce.iam.gserviceaccount.com"
    environment_variables = local.env_map
  }

}

resource "google_cloudfunctions2_function_iam_member" "public_invoker" {
  project        = google_cloudfunctions2_function.get_data.project
  location       = google_cloudfunctions2_function.get_data.location
  cloud_function = google_cloudfunctions2_function.get_data.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}