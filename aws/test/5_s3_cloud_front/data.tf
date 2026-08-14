
data "aws_s3_bucket" "s3" {
  bucket = "codeparce"
}


data "terraform_remote_state" "tfrs" {
  backend = "s3"
  config = {
    bucket = "codeparce"
    key    = "test/4_route_53/terraform.tfstate"
    region = "us-east-1"
  }
}
