module "app1_prod_cdn" {
  source = "./cloud_front"
  app_name              = "app1"
  environment           = "prod"
  s3_bucket_domain_name = data.aws_s3_bucket.s3.bucket_regional_domain_name
  cert = data.aws_acm_certificate.cert.arn
  hosted_zone_id =   data.aws_route53_zone.hz.id
}

module "app2_prod_cdn" {
  source = "./cloud_front"
  app_name              = "app2"
  environment           = "prod"
  s3_bucket_domain_name = data.aws_s3_bucket.s3.bucket_regional_domain_name
  cert = data.aws_acm_certificate.cert.arn
  hosted_zone_id = data.aws_route53_zone.hz.id
}