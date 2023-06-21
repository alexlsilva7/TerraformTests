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

resource "aws_launch_template" "maquina" {
  image_id = "ami-053b0d53c279acc90" // Ubuntu Server 22.04 LTS
  instance_type = var.instancia
  key_name = var.chave
  security_group_names = [var.security_group_name]
  tags = {
    Name = "Terraform Ansible Python"
  }
  user_data = var.producao ? filebase64("ansible.sh") : ""
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  availability_zones = ["${var.regiao_aws}a", "${var.regiao_aws}b"]
  name = var.auto_scaling_group_name
  max_size = var.max_size
  min_size = var.min_size
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  target_group_arns = var.producao ? [aws_lb_target_group.target_group[0].arn] : []
}

resource "aws_autoscaling_schedule" "on" {
  scheduled_action_name = "on"
  min_size = 0
  max_size = 1
  desired_capacity = 1
  # start at 7am
  recurrence = "0 7 * * MON-FRI"
  start_time = timeadd(timestamp(), "3m")
  time_zone = "America/Sao_Paulo"

  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}

resource "aws_autoscaling_schedule" "off" {
  scheduled_action_name = "off"
  min_size = 0
  max_size = 0
  desired_capacity = 0

  # stop at 6pm
  recurrence = "0 18 * * MON-FRI"
  start_time = timeadd(timestamp(), "4m")
  time_zone = "America/Sao_Paulo"

  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}b"
}

resource "aws_lb" "load_balancer" {
  internal = false
  subnets = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
  security_groups = [aws_security_group.acesso_geral.id]
  count = var.producao ? 1 : 0
}

resource "aws_lb_target_group" "target_group" {
  name = "target-group"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
  count = var.producao ? 1 : 0
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_lb_listener" "listenerLB" {
  load_balancer_arn = aws_lb.load_balancer[0].arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }
  count = var.producao ? 1 : 0
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name = "terraform-scale_up_policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = var.auto_scaling_group_name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0
  }
  count = var.producao ? 1 : 0
}