module "homolog" {
  source = "../../infra"
  instance_type = "t2.micro"
  min_size = 1
  max_size = 1
  name = "docker-elasticbeanstalk-homolog"
  description = "aplicação de teste do curso de IaC com Terraform, Docker e Elastic Beanstalk"
  environment_name = "homolog-env"
}