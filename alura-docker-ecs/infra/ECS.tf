 module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  
  name = var.environment
  container_insights = true
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      
    }
  ]
 }

resource "aws_ecs_task_definition" "app" {
  family = "Django-API"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  execution_role_arn = aws_iam_role.role.arn
  container_definitions = jsonencode([
    {
      "name" = var.environment
      "image" = "${aws_ecr_repository.repository.repository_url}/producao:v1"
      "cpu" = 256
      "memory" = 512
      "essential" = true
      "portMappings" = [
        {
          "containerPort" = 8000
          "hostPort" = 8000
        }
      ]
    }
  ])
}