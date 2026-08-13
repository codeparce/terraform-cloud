module "app1_prod_cdn" {
  source = "./cf"
  app_name              = "app1"
  environment           = "prod"
  s3_bucket_domain_name = data.aws_s3_bucket.s3.bucket_regional_domain_name
}

module "app2_prod_cdn" {
  source = "./cf"
  app_name              = "app2"
  environment           = "prod"
  s3_bucket_domain_name = data.aws_s3_bucket.s3.bucket_regional_domain_name
}