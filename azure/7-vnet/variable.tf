variable "location" {
  default     = "East"
  description = "locacion del Resource Group"
  type        = string
}

variable "resource_group_name" {
  default     = "rg-service-free"
  description = "nombre del Resource Group"
  type        = string
}

variable "acr_name" {
  default     = "docker.registry.xyz"
  description = "Nombre del Azure Container Registry"
  type        = string
}

variable "env" {
  default     = "xyz"
  description = "Entorno de despliegue (dev, staging, prod)"
  type = string
}

variable "sp_object_id" {
  default     = "bdbfd667-0693-4879-b062-8ff2c19dbe7f"
  description = "Object ID del Service Principal con permisos para el ACR"
  type        = string
}