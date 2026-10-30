variable "vpc_id" {
  type = string
  default = "vpc-0a72614068e381e5a"
}

variable "subnet_ids" {
  type = list(string)
  default = ["subnet-0a72614068example"]
}
variable "ec2_sg_id" {
  type = string
  default = "i-a72614068e381e5a"
}