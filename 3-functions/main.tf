
data "google_storage_bucket" "existing_bucket" {
  name = var.bucket_name
}

locals {
  env_file = file("${path.module}/.env")

  env_map = {
    for line in split("\n", local.env_file) :
    split("=", line)[0] => split("=", line)[1]
    if length(trim(line)) > 0
  }
}


resource "google_cloudfunctions2_function" "get_data" {
  name     = var.func_name
  location = var.region

  build_config {
    runtime     = "nodejs20"
    entry_point = "getData"

    source {
      storage_source {
        bucket = var.bucket_name
        object = "/functions/" + var.func_name + ".zip"
      }
    }
  }

  service_config {
    available_memory   = "256M"
    timeout_seconds    = 60
    max_instance_count = 1

    environment_variables = local.env_map
  }

  depends_on = [
    google_project_service.functions,
    google_project_service.run,
    google_project_service.cloudbuild
  ]

}



resource "google_cloud_run_service_iam_member" "public" {
  location = google_cloudfunctions2_function.get_data.location
  service  = google_cloudfunctions2_function.get_data.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
