resource "aws_db_subnet_group" "cloud-state-rds-subgrp" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "cloud-state-ecache-subgrp" {
  name       = "cloud-state-ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet group for Elasticache"
  }

}

resource "aws_db_instance" "cloud-state-RDS" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  multi_az               = false
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.cloud-state-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.cloud-state-backend-sg.id]
}

resource "aws_elasticache_cluster" "cloud-state-ecache" {
  cluster_id           = "cloud-state-ecache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.cloud-state-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.cloud-state-ecache-subgrp.name
}

resource "aws_mq_broker" "cloud-state-rmq" {
  broker_name = "cloud-state-rmq"

  engine_type        = "ActiveMQ"
  engine_version     = "5.17.6"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.cloud-state-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}
