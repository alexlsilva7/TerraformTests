resource "aws_security_group" "acesso_geral" {
  name = var.security_group_name
  description = "grupo de seguranca para acesso geral"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "acesso geral"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "acesso geral"
  }
  tags = {
    Name = "acesso_geral"
  }
}