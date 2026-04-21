variable "LOCATION" {
  default     = "eastus2"
  description = "locacion del Resource Group"
  type        = string
}

variable "RG_NAME" {
  default     = "lab-003-postgres-main"
  description = "nombre del Resource Group"
  type        = string
}

variable "PROJECT_NAME" {
  default     = "postgresql-server-lab"
  description = "nombre del proyecto para etiquetado"
  type        = string
}

variable "OWNER" {
  default     = "codeparce"
  description = "nombre del propietario para etiquetado"
  type        = string
}

variable "SQL_PASSWORD" {
  default     = "Password123!"
  description = "Contraseña del administrador de SQL Server"
  type        = string
}

variable "SQL_USERNAME" {
  default     = "sqladmin"
  description = "Nombre de usuario del administrador de SQL Server"
  type = string
}

variable "IP_TEST" {
  description = "Dirección IP de prueba para el firewall de SQL Server"
  type = string
}
## curl ipinfo.io/ip en windows para ver la ip publica