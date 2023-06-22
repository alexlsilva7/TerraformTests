module "prod" {
  source = "../../infra"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 5
  name = "docker-elasticbeanstalk-prod"
  description = "aplicação de produção do curso de IaC com Terraform, Docker e Elastic Beanstalk"
  environment_name = "prod-env"
}