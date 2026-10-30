output "distributions" {
  value = module.my_cdn
}

# output "cert" {
#   value = aws_acm_certificate.cert
# }

output "cert" {
  value = {
    domain_validation_options: aws_acm_certificate.cert.domain_validation_options,
    arn : aws_acm_certificate.cert.arn
  }
}