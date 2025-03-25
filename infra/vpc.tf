resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "alb_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 6)
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.vpc_name}_subnet_b_alb"
  }
}

resource "aws_subnet" "alb_subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, 5)

  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.vpc_name}_subnet_a_alb"
  }
}

resource "aws_subnet" "app_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 4)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.vpc_name}_subnet_b_app"
  }
}

resource "aws_subnet" "app_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 3)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.vpc_name}_subnet_a_app"
  }
}

resource "aws_subnet" "db_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 2)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.vpc_name}_subnet_b_db"
  }
}

resource "aws_subnet" "db_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.vpc_name}_subnet_a_db"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}_igw"
  }
}

resource "aws_route_table" "alb_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}_route_table_alb"
  }
}

resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}_route_table_app"
  }
}

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}_route_table_db"
  }
}

resource "aws_route_table_association" "rt-association-alb-subnet-a" {
  subnet_id      = aws_subnet.alb_subnet_a.id
  route_table_id = aws_route_table.alb_rt.id
}

resource "aws_route_table_association" "rt-association-alb-subnet-b" {
  subnet_id      = aws_subnet.alb_subnet_b.id
  route_table_id = aws_route_table.alb_rt.id
}

resource "aws_route_table_association" "rt-association-app-subnet-a" {
  subnet_id      = aws_subnet.app_subnet_a.id
  route_table_id = aws_route_table.app_rt.id
}

resource "aws_route_table_association" "rt-association-app-subnet-b" {
  subnet_id      = aws_subnet.app_subnet_b.id
  route_table_id = aws_route_table.app_rt.id
}

resource "aws_route_table_association" "rt-association-db-subnet-a" {
  subnet_id      = aws_subnet.db_subnet_a.id
  route_table_id = aws_route_table.db_rt.id
}

resource "aws_route_table_association" "rt-association-db-subnet-b" {
  subnet_id      = aws_subnet.db_subnet_b.id
  route_table_id = aws_route_table.db_rt.id
}