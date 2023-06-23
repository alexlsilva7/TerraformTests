module "prod" {
  source = "../../infra"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 5
  name = "docker-ecs-prod"
  description = "aplicação de produção do curso de Infraestrutura como código: Terraform, Docker e Elastic Container Service da Alura"
  environment_name = "prod-env"
}