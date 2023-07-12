module "prod" {
  source = "../../infra"
  repository_name = "alura-docker-ecs"
  iam_role_name = "alura-docker-ecs-prod"
}

output "lb_dns" {
  value = module.prod.load_balancer_dns
}