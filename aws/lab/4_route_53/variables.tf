variable "cert_domain_name" {
  type      = string
  default = "*.prod.codeparce.site"
}

variable "domain_name" {
  type = string
  default = "prod.codeparce.site"
}

variable "cloudflare_api_token" {
  type      = string
  default = "NN"
  sensitive = true
}

variable "cloudflare_zone_id" {
  default = "NN"
  type = string
}
