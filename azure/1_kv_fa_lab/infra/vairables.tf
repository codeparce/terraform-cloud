variable "env" {
  description = "Ambiente de despliegue (dev, stg, prod)"
  type        = string
  default     = "test"
}

variable "location" {
  description = "Location"
  type        = string
  default = "East US"
}

variable "user_object_id" {
  description = "El Object ID del usuario de Azure AD que será el Officer"
  type        = string
}


