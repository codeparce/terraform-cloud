variable "LOCATION" {
  default     = "East US"
  description = "locacion del Resource Group"
  type        = string
}

variable "RESOURCE_GROUP_NAME" {
  default     = "rg-springboot-free"
  description = "nombre del Resource Group"
  type        = string
}

variable "CONTAINER_ENVIRONMENT" {
  default     = "continer-environment-app"
  description = "nombre del Container App Environment"
  type        = string
}

variable "CONTAINER_ENVIRONMENT_RG" {
  default     = "continer-environment-app"
  description = "nombre del Resource Group del Container App Environment"
  type        = string
}


variable "CONTAINER_APP_NAME" {
  default     = "continer-app-example"
  description = "nombre del Container App"
  type        = string
}

variable "CONTAINER_IMAGE" {
  default     = "continer-app-example:main"
  description = "camino de la imagen del contenedor"
  type        = string
}
