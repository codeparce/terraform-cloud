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

variable "app_service_plan_name" {
  default     = "asp-springboot-free"
  description = "nombre del App Service Plan"
  type        = string
}

variable "app_name" {
  default     = "api-springboot-free"
  description = "nombre de la aplicacion web"
  type        = string
}
