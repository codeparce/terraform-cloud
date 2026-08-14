resource "cloudflare_dns_record" "certificate" { # 2 Creacion del cnma del cert en cloud flare
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => dvo
  }
  # Depende de la creacion del certificado en aws

  zone_id = var.cloudflare_zone_id

  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  content = each.value.resource_record_value

  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "subdomine" { # 5. Creacion del subdominio en cloud flare
  zone_id = var.cloudflare_zone_id

  name = "${var.app_name}.${var.env}"

  type = "CNAME"

  content = module.my_cdn.cloudfront_distribution_domain_name

  ttl     = 1
  proxied = false
}