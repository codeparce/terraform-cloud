terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

resource "google_storage_bucket" "tf_state" {
  name     = "${var.project_id}-tfstate"
  location = "US"

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true

  # lifecycle_rule {
  #   action {
  #     type = "Delete"
  #   }
  #   condition {
  #   }
  # }
}
