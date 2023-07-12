# Public ALB Security Group

resource "aws_security_group" "ssh_cluster" {
  name = "ssh_cluster"
  description = "Security group for ALB"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ssh_cluster_inbound" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_cluster.id
}

resource "aws_security_group_rule" "ssh_cluster_outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_cluster.id
}

# Private Security Group

resource "aws_security_group" "private" {
  name = "private"
  description = "Security group for private instances"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "private_inbound" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  # receive traffic from ALB
  source_security_group_id = aws_security_group.alb.id
  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "private_outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private.id
}
