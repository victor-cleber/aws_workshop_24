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

output "jh_public_ip" {
  value     = aws_instance.app_server.public_ip
  sensitive = false
}