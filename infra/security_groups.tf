# Instance Security group (traffic ALB -> EC2, ssh -> EC2)
resource "aws_security_group" "alb_security_group" {
  name        = "security_group_alb"
  description = "Allows inbound access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {    
    Name = "${var.vpc_name}_sg_alb"
  }
}

resource "aws_security_group" "app_security_group" {
  name        = "security_group_app"
  description = "Allow Connections to web server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "From ALB - HTTPS ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"    
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description = "From ALB - HTTP ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {    
    Name = "${var.vpc_name}_sg_app"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "database_security_group" {
  name        = "security_group_db"
  description = "Allow mariaDb access on port 3306"
  vpc_id      = aws_vpc.main.id


  ingress {
    description     = "From APP - MariaDb ingress"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {    
    Name = "${var.vpc_name}_sg_db"
  }

  lifecycle {
    create_before_destroy = true
  }
}