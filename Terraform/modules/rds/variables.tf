variable "vpc_id" {
  description = "VPC id for the resources"
  type        = string
}

variable "security_groups" {
  description = "Security group"
  type        = list(string)
}

variable "subnets" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "rds_database_name" {
  description = "Name of the database"
  type        = string
}

variable "rds_master_username" {
  description = "Master username for the database"
  type        = string
}

variable "rds_instance_class" {
  description = "Instance class for the database"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Allocated storage"
  default     = 20
  type        = number
}

variable "rds_engine_version" {
  description = "Engine version for the db"
  type        = string
}

variable "multi_az" {
  description = "Set to 'true' to deploy the rds instance as multi-az"
  default     = false
  type        = bool
}

variable "backup_retention_period" {
  description = "Backup retention period"
  default     = 7
  type        = number
}

variable "storage_type" {
  description = "Storage type for the db"
  default     = "gp2"
  type        = string
}


variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed"
  default     = false
  type        = bool
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = false
  type        = bool
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
  type        = bool
}

variable "engine" {
  description = "Define the engine for the database"
  type        = string
}

variable "identifier" {
  description = "The name for the resources"
  type        = string
}

variable "license_model" {
  description = "License model information for this DB instance"
  default     = null
  type        = string
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  default     = false
  type        = bool
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot"
  default     = null
  type        = string
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  default     = false
  type        = bool
}

variable "performance_insights" {
  description = "Specifies whether Performance Insights are enabled"
  default     = false
  type        = bool
}

variable "performance_insights_retention_period" {
  description = "he amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true"
  default     = 7
  type        = number
}

variable "parameters" {
  description = "A list of DB parameters to apply"
  default     = []
  type = list(object({
    name  = string
    value = string
  }))
}


variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  default     = null
  type        = string
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to enable for exporting to CloudWatch logs"
  default     = []
  type        = list(string)
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots"
  default     = true
  type        = bool
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  default     = 0
  type        = number
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  default     = ""
  type        = string
}

variable "family" {
  type    = string
  default = ""
}