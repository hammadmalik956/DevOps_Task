resource "aws_instance" "ec2" {
  ami                         = var.ec2_config.ami
  instance_type               = var.ec2_config.cpu
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.ec2_sg_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.ec2_config.associate_public_ip_address
  user_data     = base64encode(templatefile("./modules/ec2/config.sh",{ DATABASE_HOST = var.rds_host} ))
  tags = {
    Name = "${terraform.workspace}-${var.project_name}"
  }
}