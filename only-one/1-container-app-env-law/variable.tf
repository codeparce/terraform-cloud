variable "location" {
  default     = "East US"
  description = "locacion del Resource Group"
  type        = string
}

variable "resource_group_name" {
  default     = "rg-springboot-free"
  description = "nombre del Resource Group"
  type        = string
}

variable "log_aw" {
  default     = "law-continer-app"
  description = "nombre del Log Analytics Workspace"
  type        = string
}

variable "container_environment" {
  default     = "continer-environment-app"
  description = "nombre del Container App Environment"
  type        = string
}
