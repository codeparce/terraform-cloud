
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-codeparce"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

## En versiones antiguas de terraform, se usaba una base de datos dynamo para poder bloquear el estado de terraform y evitar que dos personas lo modifiquen al mismo tiempo. provider -> dynamodb_table = "terraform_state"

## ahora se utiliza use_lockfile = true y eso bloquea automaticamnete el estado

# resource "aws_dynamodb_table" "terraform_lock" {
#   name = "terraform_state"

#   billing_mode   = "PROVISIONED"
#   read_capacity  = 1
#   write_capacity = 1

#   hash_key = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
#   tags = {
#     "terraform" = "true"
#     "env"       = "test"
#     "desc"      = "DynamoDB Terraform State Lock Table"
#   }

# }
