output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "rds_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}

output "rds_username" {
  value     = aws_db_instance.db_instance.username
  sensitive = true
}

output "rds_password" {
  value     = aws_db_instance.db_instance.password
  sensitive = true
}