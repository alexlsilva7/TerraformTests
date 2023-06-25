# Public ALB Security Group

resource "aws_security_group" "alb" {
  name = "alb"
  description = "Security group for ALB"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "alb_http" {
  type = "ingress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "alb_outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
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
