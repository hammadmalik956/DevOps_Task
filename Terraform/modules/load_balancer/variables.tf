variable "vpc_id" {
  description = "VPC id for the resources"
  type        = string
}

variable "subnet_ids" {
  description = "IDs of subnets"
  type        = list(string)
}



variable "sg_id" {
  description = "ID of security group"
  type        = list(string)
}
variable "lb_conf" {}
