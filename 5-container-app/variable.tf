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

variable "container_environment" {
  default     = "continer-environment-app"
  description = "nombre del Container App Environment"
  type        = string
}

variable "container_environment_rg" {
  default     = "continer-environment-app"
  description = "nombre del Resource Group del Container App Environment"
  type        = string
}


variable "container_app_name" {
  default     = "continer-app-example"
  description = "nombre del Container App"
  type        = string
}

variable "container_image" {
  default     = "continer-app-example:main"
  description = "camino de la imagen del contenedor"
  type        = string
}
