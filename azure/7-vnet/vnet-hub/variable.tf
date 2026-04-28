variable "location" {
  default     = "East US"
  description = "locacion del Resource Group"
  type        = string
}

variable "rg_name" {
  default     = "rg-lab-hub-spoke"
  description = "nombre del Resource Group"
  type        = string
}

variable "vnet_hub" {
  default = "10.0.0.0/16"
}

variable "vnet_spoke" {
    type = map(string)
  default = {
    dev = "10.1.0.0/24"
    prod = "10.2.0.0/24"
  }
}
