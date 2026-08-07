module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "my-alb"
  vpc_id  = data.aws_vpc.vpc.id
  subnets = data.aws_subnets.vpc_subnets.ids

  enable_deletion_protection = false


  create_security_group = false
  security_groups       = [aws_security_group.lb_sg.id]

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
                  "/ec2/*", "/ec2"

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
      target_id                = data.aws_lambda_function.api.arn
      attach_lambda_permission = true
    }
    ec2 = {
      target_type              = "instance"
      target_id                = data.aws_instance.ec2.id
      attach_lambda_permission = false
    }
  }

  tags = {
    env  = "lab"
    name = "alb"
  }
}

