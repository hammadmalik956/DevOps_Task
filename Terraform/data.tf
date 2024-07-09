data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu_ami.id
}



data "aws_secretsmanager_secret" "mysql-by-arn" {
  arn = module.mysql_rds.output.secret_manager
}
data "aws_secretsmanager_secret_version" "mysql_rds" {
  secret_id  = data.aws_secretsmanager_secret.mysql-by-arn.id
  depends_on = [module.mysql_rds]
}
