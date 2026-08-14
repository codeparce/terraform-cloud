module "my_cdn" { # 4. Creacion de la Distribucion
  source = "terraform-aws-modules/cloudfront/aws"

  # Depende de la creacion y la validacion del certificado 

  aliases = [
    "app1.test.codeparce.site"
  ]
  comment = "${var.app_name}-${var.env}"
  enabled = true

  default_root_object = "index.html"

  custom_error_response = [
    {
      error_caching_min_ttl = 10
      error_code            = 404
      response_code         = 200
      response_page_path    = "/error.html"
    },
    {
      error_caching_min_ttl = 10
      error_code            = 403
      response_code         = 200
      response_page_path    = "/error.html"
    }
  ]

  origin_access_control = {
    s3 = {
      name             = "${var.app_name}-${var.env}-s3-oac"
      description      = "CloudFront access to S3 ${var.app_name}-${var.env}"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    "${var.app_name}-${var.env}" = {
      domain_name               = var.s3_bucket_domain_name
      origin_path               = "/cloud-front/${var.env}/${var.app_name}"
      origin_access_control_key = "s3"
    }
  }

  default_cache_behavior = {
    target_origin_id       = "${var.app_name}-${var.env}"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    compress     = true
    query_string = true
  }

  viewer_certificate = {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
