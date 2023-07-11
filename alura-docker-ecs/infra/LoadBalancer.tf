resource "aws_lb" "load_balancer" {
  name               = "alura-docker-ecs-django"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 8000
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "alura-docker-ecs-django"
  port     = 8000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = module.vpc.vpc_id
}

output "load_balancer_dns" {
  value = aws_lb.load_balancer.dns_name
}