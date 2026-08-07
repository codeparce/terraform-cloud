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

# variable "ecs_id" {
#   description = "ECS Cluster ID"
#   type        = string
# }
