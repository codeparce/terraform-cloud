variable "STATIC_APP_NAME" {
  description = "Nombre del Static Web App"
  default     = "myapp"
  type        = string
}


variable "RESOURCE_GROUP_NAME" {
  description = "Nombre del Resource Group"
  default     = "rg-static-apps-main"
  type        = string
}

variable "LOCATION" {
  description = "Location of the Resource Group"
  default     = "eastus"
  type        = string
}
