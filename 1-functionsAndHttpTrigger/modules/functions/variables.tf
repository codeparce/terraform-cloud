variable "name" {}
variable "location" {}
variable "resource_group_name" {}

variable "storage_account_name" {
  type = string
}

variable "storage_account_access_key" {
  type      = string
  sensitive = true
}
