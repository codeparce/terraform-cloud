variable "resource_group_name" {}
variable "location" {}
variable "key_vault_name" {}
variable "objct_id" {}
variable "db_url" {
  sensitive = true
}
