module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "alb-test"
  vpc_id  = var.vpc_id
  subnets = var.subnets

  enable_deletion_protection = false


  create_security_group = false
  security_groups       = [var.sg_alb_id]

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "ecs"
      }

    }


  }

  target_groups = {

    ecs = {
      name              = "tg-ecs"
      target_type       = "ip"
      port              = 80
      protocol          = "HTTP"
      create_attachment = false

      health_check = {
        enabled             = true
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 3
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200"
      }

    }
  }

  tags = {
    env  = "lab"
    name = "alb"
  }
}

