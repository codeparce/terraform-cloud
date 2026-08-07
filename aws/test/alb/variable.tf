variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "Subnets"
  type        = list(string)
}

variable "sg_alb_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "ec2_id" {
  description = "EC2 Instance ID"
  type        = string
}
