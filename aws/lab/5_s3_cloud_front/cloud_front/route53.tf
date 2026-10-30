resource "aws_route53_record" "app1" {
  zone_id = var.hosted_zone_id
  name    = "${var.app_name}.prod.codeparce.site"
  type    = "A"

  alias {
    name                   = module.my_cdn.cloudfront_distribution_domain_name
    zone_id                = module.my_cdn.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}