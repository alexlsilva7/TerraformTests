resource "aws_elastic_beanstalk_application" "beanstalk_app" {
  name = var.name
  description = var.description
}

resource "aws_elastic_beanstalk_environment" "beanstalk_env" {
  name = var.environment_name
  application = aws_elastic_beanstalk_application.beanstalk_app.name

  solution_stack_name = "64bit Amazon Linux 2 v3.5.8 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = var.max_size
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = var.min_size
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = aws_iam_instance_profile.beanstalk_ec2.name
  }
}

resource "aws_elastic_beanstalk_application_version" "beanstalk_app_version" {
  name = var.environment_name
  application = var.name
  bucket = aws_s3_bucket.beanstalk_deploys.id
  key = aws_s3_object.docker.id
  depends_on = [ 
    aws_elastic_beanstalk_environment.beanstalk_env,
    aws_elastic_beanstalk_application.beanstalk_app,
    aws_s3_object.docker
  ]
}

# deploy  aws elasticbeanstalk update-environment --environment-name prod-env --version-label prod-env

