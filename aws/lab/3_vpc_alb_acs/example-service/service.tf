resource "aws_ecs_service" "app" {
  depends_on      = [aws_ecs_task_definition.td]
  name            = "blue-green-apps"
  cluster         = "arn:aws:ecs:us-east-1:464453620485:cluster/ecs-cluster-test"
  task_definition = aws_ecs_task_definition.td.arn
  desired_count   = 2


  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base = 20
    weight = 50
  }

  network_configuration {
    subnets         = ["subnet-0da5abe515c7ce7bb", "subnet-052f740e426896e1e"]
    security_groups = ["sg-00acf234f1fb65f3a"]
  }

  load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:464453620485:targetgroup/tg-ecs/0d570af9e6bfef51"
    container_name   = "blue-green-apps"
    container_port   = 80
  }

  tags_all = {
    env : "test",
    terraform : true,
    proyect : "ecs"
  }

}
