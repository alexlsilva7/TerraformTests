module "prod" {
  source = "../../infra"
  repository_name = "alura-docker-ecs"
  cluster_name = "alura-terraform-kubernets-prod"
}