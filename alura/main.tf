terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.9"
}

# Configure the AWS Provider
provider "aws" {
  profile = "default"
  region = "us-east-1"

}

resource "aws_instance" "app_server" {
  ami = "ami-022e1a32d3f742bd8" // Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  key_name = "alura"

  tags = {
    Name = "Primeira instancia com Terraform"
  }
}
