output "hosted_zone" {
  value = aws_route53_zone.hz
}

output "cert" {
  value = aws_acm_certificate.cert
  sensitive = true
}

