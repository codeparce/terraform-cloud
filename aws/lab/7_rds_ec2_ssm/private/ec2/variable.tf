variable "vms_confg" {
  type = map(object({
    name      = string
  }))
  default = {
    "vm1" = { name = "vm-sis-01-example"}
  }
}

variable "vpc_id" {
  type = string
  default = "vpc-0a72614068e381e5a"
}

variable "subnet_ids" {
  type = list(string)
  default = ["subnet-0a72614068example"]
}