module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-east-1"
  chave = "Iac-Dev"
  security_group_name = "acesso_geral_dev"
}

output "ip_publico_dev" {
  value = module.aws-dev.ip_publico
}