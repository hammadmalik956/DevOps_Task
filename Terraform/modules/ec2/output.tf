output "ec2_publicIp" {
  value = aws_instance.ec2.public_ip
}
output "ec2_instance_id" {
  value = aws_instance.ec2.id
}
output "ec2_instance_dns" {
  value = aws_instance.ec2.public_dns
}