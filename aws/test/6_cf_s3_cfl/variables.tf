variable "cloudflare_api_token" {
  type      = string
  default = "NN"
  sensitive = true
}

variable "cloudflare_zone_id" {
  default = "NN"
  type = string
}
