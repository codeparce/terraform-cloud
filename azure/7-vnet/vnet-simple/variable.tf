variable "location" {
  default     = "East US"
  description = "locacion del Resource Group"
  type        = string
}

variable "rg_name" {
  default     = "rg-lab-1-2-3"
  description = "nombre del Resource Group"
  type        = string
}

variable "vnet_cidr" {
  default = "10.0.0.0/16"
}

variable "subnets" {
  default = {
    web = "10.0.1.0/24"
    app = "10.0.2.0/24"
  }
}
