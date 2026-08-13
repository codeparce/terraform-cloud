
data "aws_s3_bucket" "s3" {
  bucket = "codeparce"
}

data "aws_route53_zone" "hz" {
  tags = {
    env : "prod"
  }
}

data "aws_acm_certificate" "cert" {
  tags = {
    cert : "prod"
  }
}
