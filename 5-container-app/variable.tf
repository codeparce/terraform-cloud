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

variable "CONTAINER_ENVIRONMENT_NAME" {
  default     = "continer-environment-app"
  description = "nombre del Container App Environment"
  type        = string
}

variable "CONTAINER_ENVIRONMENT_RG" {
  default     = "continer-environment-app"
  description = "nombre del Resource Group del Container App Environment"
  type        = string
}

## variables para la imagen del contenedor 
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

## variables para el contenedor y el escalado
variable "CPU" {
  default     = 0.5
  description = "cantidad de CPU para el contenedor"
  type        = number
}

variable "MEMORY" {
  default     = "1Gi"
  description = "cantidad de memoria para el contenedor"
  type        = string
}

variable "MIN_REPLICAS" {
  default     = 0
  description = "numero minimo de replicas para el contenedor"
  type        = number
}

variable "MAX_REPLICAS" {
  default     = 1
  description = "numero maximo de replicas para el contenedor"
  type        = number
}

variable "EXTERNAL_ENABLED" {
  default     = false
  description = "habilitar acceso externo al contenedor"
  type        = bool
}

