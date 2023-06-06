resource "aws_db_subnet_group" "main" {
  name       = "${local.prefix}-db-subnet-gp"
  subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-db-subnet-gp"})
  )
}

resource "aws_security_group" "db_SG" {
  name        = "${local.prefix}-db-SG"
  description = "Allow inbound traffic to RDS DB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Inbound traffic to DB"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion.id, aws_security_group.ecs_service.id]
  }

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-db-SG"})
  )
}

resource "aws_db_instance" "main" {
  allocated_storage           = 20
  db_name                     = "recipes"
  identifier                  = "${local.prefix}-db"
  engine                      = "postgres"
  engine_version              = "12"
  instance_class              = "db.t2.micro"
  username                    = var.db_user
  password                    = var.db_password
  backup_retention_period     = 0
  skip_final_snapshot         = true
  db_subnet_group_name        = aws_db_subnet_group.main.name
  multi_az                    = false
  storage_type                = "gp2"
  vpc_security_group_ids      = [aws_security_group.db_SG.id]

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-db-instance"})
  )
}
