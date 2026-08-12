resource "aws_ecs_task_definition" "td" {
  family                   = "tdf-blue-green-apps"
  execution_role_arn       = "arn:aws:iam::464453620485:role/ecsTaskExecutionRole"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name      = "blue-green-apps"
      image     = "codeparce/blue-gren:blue"
      cpu       = 256
      memory    = 512
      
      essential = true
      "environment" : [
        { "name" : "blue-green-apps", "value" : "test" }
      ],
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },

  ])

  tags_all = {
    env : "test",
    terraform : true,
    proyect : "ecs"
  }


}

