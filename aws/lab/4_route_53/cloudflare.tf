resource "cloudflare_dns_record" "ns" {
  zone_id = var.cloudflare_zone_id

  depends_on = [ aws_route53_zone.hz ]
  for_each = toset(aws_route53_zone.hz.name_servers)
  name    = "prod"
  type    = "NS"

  content = each.value
  
  ttl     = 1
  proxied = false
}

