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
  ami = "ami-053b0d53c279acc90" // Ubuntu Server 22.04 LTS
  instance_type = "t2.micro"
  key_name = "alura"
#   user_data = <<EOF
#               #!/bin/bash
#               echo "<h1>Hello World</h1>" > index.html
#               nohup busybox httpd -f -p 8080 &
#               EOF

  tags = {
    Name = "Terraform Ansible Python"
  }
}
