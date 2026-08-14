resource "aws_acm_certificate" "cert" { # 1 Certificado aws 
  domain_name = var.cert_domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    env: "test"
    type: "all"
  }
}

resource "aws_acm_certificate_validation" "cert" { # 3 Validacion del certifcado
  certificate_arn = aws_acm_certificate.cert.arn

  # Depende de la creacion del record en cloud flare

  validation_record_fqdns = [
    for record in cloudflare_dns_record.certificate :
    record.name
  ]
}