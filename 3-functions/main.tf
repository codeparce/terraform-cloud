resource "google_project_service" "functions" {
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbuild" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

data "google_storage_bucket" "existing_bucket" {
  name = var.bucket_name
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "functions/functions.zip"
  bucket = data.google_storage_bucket.existing_bucket.name
  source = "${path.module}/functions/functions.zip"
}

resource "google_cloudfunctions2_function" "get_data" {
  name     = "get-data"
  location = "us-central1"

  build_config {
    runtime     = "nodejs20"
    entry_point = "getData"

    source {
      storage_source {
        bucket = var.bucket_name
        object = google_storage_bucket_object.function_zip.name
      }
    }
  }

  service_config {
    available_memory   = "256M"
    timeout_seconds    = 60
    max_instance_count = 1

    environment_variables = {
      PROJECT_ID            = var.project_id
      FIRESTORE_DATABASE_ID = var.firestore_name
      BUCKET = var.bucket_name
    }
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
