module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-east-1"
  chave = "Iac-Prod"
  security_group_name = "acesso_geral_prod"

  auto_scaling_group_name = "Prod"
  max_size = 10
  min_size = 1

  producao = true
}