resource "aws_route53_zone" "hz" {
  name = var.domain_name

  tags = {
    name = "${var.domain_name}"
    env  = "prod"
  }
}
