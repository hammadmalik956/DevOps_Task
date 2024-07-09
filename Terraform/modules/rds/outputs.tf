output "output" {
  value = {
    db_endpoint    = aws_db_instance.main.endpoint
    secret_manager = aws_secretsmanager_secret.db_secret.arn

  }
}