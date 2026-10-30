module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "my-alb"
  vpc_id  = var.vpc_id
  subnets = var.subnets

  enable_deletion_protection = false


  create_security_group = false
  security_groups       = [var.sg_alb_id]

  # access_logs = {

  #   bucket = "codeparce"
  # }
  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      fixed_response = {
        content_type = "text/plain"
        message_body = "Not Found"
        status_code  = "404"
      }

      rules = {
        api = {
          priority = 10

          actions = [
            {
              type = "forward"

              forward = {
                target_group_key = "lambda"
              }
            }
          ]

          conditions = [
            {
              path_pattern = {
                values = [
                  "/api/*", "/api"

                ]
              }
            }
          ]
        }
      }
    }

    instance = {
      port     = 80
      protocol = "HTTP"

      fixed_response = {
        content_type = "text/plain"
        message_body = "Not Found"
        status_code  = "404"
      }

      rules = {
        api = {
          priority = 20

          actions = [
            {
              type = "forward"

              forward = {
                target_group_key = "ec2"
              }
            }
          ]

          conditions = [
            {
              path_pattern = {
                values = [
                  "/"
                ]
              }
            }
          ]
        }
      }

    }
  }

  target_groups = {
    lambda = {
      target_type              = "lambda"
      target_id                = var.lambda.arn
      attach_lambda_permission = true
    }
    ec2 = {
      target_type              = "instance"
      target_id                = var.ec2_id
      attach_lambda_permission = false
    }
  }

  tags = {
    env  = "lab"
    name = "alb"
  }
}

