output "hosted_zone" {
  value = aws_route53_zone.hz
}

output "cert_id" {
  value = aws_acm_certificate.cert.id
}

output "cert_validate_options" {
  value = aws_acm_certificate.cert.domain_validation_options
}

