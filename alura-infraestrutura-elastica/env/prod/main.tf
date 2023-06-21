module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-east-1"
  chave = "Iac-Prod"
  security_group_name = "acesso_geral_prod"
}

output "ip_publico_prod" {
  value = module.aws-prod.ip_publico
}