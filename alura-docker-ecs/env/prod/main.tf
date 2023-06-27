module "prod" {
  source = "../../infra"
  repository_name = "alura-docker-ecs"
  iam_role_name = "alura-docker-ecs-prod"
}