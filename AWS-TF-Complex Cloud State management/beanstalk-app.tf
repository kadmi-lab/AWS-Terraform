resource "aws_elastic_beanstalk_application" "cloud-state-beanstalk-app" {
  name        = "cloud-state-beanstalk-app"
  description = "Beanstalk app"
}


resource "aws_elastic_beanstalk_environment" "cloud-state-beanstalk-prod" {
  name                = "cloud-state-beanstalk-prod"
  application         = aws_elastic_beanstalk_application.cloud-state-beanstalk-app.name
  solution_stack_name = "64bit Amazon Linux 2023 v5.1.4 running Tomcat 10 Corretto 17"
  cname_prefix        = "cloud-state-beanstalk-domain"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]])
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]])
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.tf-cloud-state-key.key_name
  }


  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 3"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "8"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "environment"
    value     = "prod"
  }


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.cloud-state-beanprod-sg.id
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.cloud-state-bean-elb-sg.id
  }


  depends_on = [aws_security_group.cloud-state-bean-elb-sg, aws_security_group.cloud-state-beanprod-sg]


}
