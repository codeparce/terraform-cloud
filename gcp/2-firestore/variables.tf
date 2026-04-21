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
