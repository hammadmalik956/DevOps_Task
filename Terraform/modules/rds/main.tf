locals {
  database_endpoint_no_port = element(split(":", aws_db_instance.main.endpoint), 0)
}

resource "aws_secretsmanager_secret" "db_secret" {
  name                           = "${var.identifier}-db-secrets-${terraform.workspace}"
  description                    = "Database superuser and password"
  recovery_window_in_days        = 0
  force_overwrite_replica_secret = true
}

resource "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    DB_USER     = var.rds_master_username
    DB_PASSWORD = random_password.password.result
    DB_NAME     = var.rds_database_name
    DB_HOST     = local.database_endpoint_no_port
    DB_PORT     = aws_db_instance.main.port
  })
}

resource "random_password" "password" {
  special = false
  length  = 16

  keepers = {
    static = "1"
  }
}

resource "aws_db_parameter_group" "default" {
  name        = "${var.identifier}-parameter-group-${terraform.workspace}"
  family      = var.family
  description = "Custom parameter group for Aurora Mysql instance"
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.identifier}-subnet-group-${terraform.workspace}"
  subnet_ids = var.subnets
}

resource "aws_db_instance" "main" {
  parameter_group_name                = aws_db_parameter_group.default.name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  final_snapshot_identifier           = "${var.identifier}-snapshot"
  backup_retention_period             = var.backup_retention_period
  vpc_security_group_ids              = var.security_groups
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.id
  publicly_accessible                 = var.publicly_accessible
  monitoring_interval                 = var.monitoring_interval
  monitoring_role_arn                 = var.monitoring_role_arn
  snapshot_identifier                 = var.snapshot_identifier
  allocated_storage                   = var.snapshot_identifier == null ? var.rds_allocated_storage : null
  apply_immediately                   = false
  storage_encrypted                   = var.storage_encrypted
  engine_version                      = var.rds_engine_version
  instance_class                      = var.rds_instance_class
  license_model                       = var.license_model
  storage_type                        = var.storage_type
  identifier                          = "${var.identifier}-${terraform.workspace}"
  username                            = var.rds_master_username
  password                            = random_password.password.result
  multi_az                            = var.multi_az
  engine                              = var.engine
  db_name                             = var.rds_database_name
  backup_window                       = "00:00-01:30"
  maintenance_window                  = "Sun:03:00-Sun:05:00"
  kms_key_id                          = var.kms_key_id
  deletion_protection                 = false
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
}