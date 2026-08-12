module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  region = "us-east-1"

  cluster_name = "ecs-cluster-test"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "DEFAULT"
    }
  }

  # Cluster capacity providers
  cluster_capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy = {
    FARGATE = {
      weight = 50
      base   = 20
    }
  }

  tags = {
    env = "test"
    Project     = "ecs"
  }
}
