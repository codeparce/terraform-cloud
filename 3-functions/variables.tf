variable "project_id" {
  description = "ID del proyecto en GCP"
  default     = "code-parce"
  type        = string
}

variable "region" {
  description = "Región"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Nombre del bucket"
  default     = "code-parce-storage-bucket"
  type        = string
}

variable "firestore_name" {
  description = "Nombre de la base de datos de Firestore"
  default     = "firestore-database"
  type        = string
}
