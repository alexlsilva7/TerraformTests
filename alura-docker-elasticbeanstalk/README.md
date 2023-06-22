# Aplicação de exemplo para o curso Infraestrutura como código: Docker e Elastic Beanstalk na AWS (https://cursos.alura.com.br/course/infraestrutura-codigo-docker-elastic-beanstalk-aws)

## Arquitetura

Arquitetura criada com o objetivo de poder ter varios ambientes.

- Separei os ambientes de homologação e produção em pastas diferentes, para facilitar a execução dos comandos.
- Criei uma pasta de infraestrutura onde coloquei os arquivos compartilhados entre os ambientes.
- Pasta da aplicação: `clientes-leo-api`

## infra

- Repositorio docker no ECR.
- Permissionamento da aplicação.
- Configuração do beanstalk (ambiente, aplicação e versão).
- Bucket S3 para armazenar os arquivos de configuração do beanstalk.
- Backend para o terraform (S3).
- Variaveis de ambiente.

## env

- Configurações de cada ambiente.
- Arquivo de configuração do beanstalk "Dockerrun.aws.json" (https://docs.aws.amazon.com/pt_br/elasticbeanstalk/latest/dg/single-container-docker-configuration.html)
  - Compactar a aplicação em um arquivo .zip (zip -r docker-elasticbeanstalk-prod.zip Dockerrun.aws.json)
- Realizar o deploy da aplicação no beanstalk (prod): aws elasticbeanstalk update-environment --environment-name prod-env --version-label prod-env


