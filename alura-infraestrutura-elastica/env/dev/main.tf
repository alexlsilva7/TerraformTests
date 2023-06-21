module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-east-1"
  chave = "Iac-Dev"
  security_group_name = "acesso_geral_dev"

  auto_scaling_group_name = "Dev"
  max_size = 1
  min_size = 0

  producao = false
}