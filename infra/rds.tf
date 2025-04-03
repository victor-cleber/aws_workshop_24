#------------------------
# RDS INSTANCES
#------------------------

resource "aws_db_instance" "db_instance" {
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.39"
  multi_az               = false
  identifier             = "workshop24"
  username               = "workshop_admin"
  password               = random_string.for_rds_password.id
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = ["${aws_security_group.database_security_group.id}"]
  #availability_zone      = var.availability_zones[0]#data.aws_availability_zones.availability_zones.names[0]
  db_name             = "db_app"
  skip_final_snapshot = true
  publicly_accessible = false
  deletion_protection = false
  tags = {
    name = "Workshop 24"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "workshop_24_subnet_group"
  subnet_ids  = [aws_subnet.db_subnet_a.id, aws_subnet.db_subnet_b.id]
  description = "subnet group for database instance"

  tags = {
    Name = "workshop_24_subnet_group"
  }
}

resource "random_string" "for_rds_password" {
  length  = 10
  lower   = true
  upper   = false
  numeric = true
  special = false
}