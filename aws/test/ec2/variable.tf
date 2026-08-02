variable "vms_confg" {
  type = map(object({
    subnet_id = string
    name      = string
    sg_id     = list(string)
  }))
  default = {
    "vm1" = { name = "vm-sis-01-test",
      subnet_id = "subnet-0a72614068e381e5a",
    sg_id = ["test"] }
  }
}
