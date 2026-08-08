terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "codeparce"
    key = "test/3_vpc_alb_acs/terraform.tfstate"
    # dynamodb_table = "terraform_state"
    use_lockfile = true
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
