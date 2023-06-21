terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.9"
}


provider "aws" {
  profile = "default"
  region = var.regiao_aws

}

resource "aws_instance" "app_server" {
  ami = "ami-053b0d53c279acc90" // Ubuntu Server 22.04 LTS
  instance_type = var.instancia
  key_name = var.chave
  security_groups = [var.security_group_name]
  tags = {
    Name = "Terraform Ansible Python"
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

output "ip_publico" {
  value = aws_instance.app_server.public_ip
}