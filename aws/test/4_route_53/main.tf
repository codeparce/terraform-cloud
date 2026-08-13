resource "aws_route53_zone" "hz" {
  name = "prod.codeparce.site"

  tags = {
    name        = "codeparce.site"
    env = "prod"
  }
}