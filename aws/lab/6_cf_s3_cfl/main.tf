module "app_test_cdn" {
  source                = "./cloud_front"
  app_name              = "app1"
  env                   = "test"
  s3_bucket_domain_name = data.aws_s3_bucket.s3.bucket_regional_domain_name
  cloudflare_zone_id    = var.cloudflare_zone_id
  cert_domain_name =   "*.test.codeparce.site"
}

