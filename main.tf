resource "aws_security_group" "security_group" {
  name        = var.security_group_name
  description = "A security group made for a Hasura Postgresql cluster"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Only allow connections from Hasura project"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [var.hasura_ip_address]
    ipv6_cidr_blocks = []
  }

  egress {
    description      = "Allow connections with anyone"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_rds_cluster" "cluster" {
  cluster_identifier     = var.cluster_identifier
  engine                 = "aurora-postgresql"
  engine_mode            = "provisioned"
  engine_version         = var.engine_version
  database_name          = var.database_name
  master_username        = var.database_username
  master_password        = var.database_password
  apply_immediately      = var.apply_immediately
  vpc_security_group_ids = [aws_security_group.security_group.id]

  serverlessv2_scaling_configuration {
    min_capacity = var.serverless_scaling_min_capacity
    max_capacity = var.serverless_scaling_max_capacity
  }
}

resource "aws_rds_cluster_instance" "instance" {
  cluster_identifier  = aws_rds_cluster.cluster.id
  identifier          = var.instance_identifier
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.cluster.engine
  engine_version      = aws_rds_cluster.cluster.engine_version
  publicly_accessible = true
  apply_immediately   = var.apply_immediately
}
