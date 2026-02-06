variable "static_app_name" {
  description = "Nombre del Static Web App"
  default     = "myapp"
  type        = string
}


variable "resource_group_name" {
  description = "Nombre del Resource Group"
  default     = "rg-myapp"
  type        = string
}

variable "location" {
  description = "Location of the Resource Group"
  default     = "eastus2"
  type        = string
}
