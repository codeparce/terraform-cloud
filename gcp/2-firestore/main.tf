resource "google_project_service" "firestore" {
  project            = var.project_id
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}

resource "google_firestore_database" "default" {
  project     = var.project_id
  name        = "firestore-database"
  location_id = var.region
  type        = "FIRESTORE_NATIVE"

  depends_on = [
    google_project_service.firestore
  ]
}
