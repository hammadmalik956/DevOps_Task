variable "vpc" {
  description = "Virtual Private Cloud configuration"
}

variable "semantic_version" {
  description = "Meaningful version scheme"
  default     = "1.0.0"
}

variable "my_public_ip" {
  description = "Public Ip of your network"
  default = "0.0.0.0/0"
}

variable "project_name" {
  description = "project name"
  default     = "new project"
}

variable "ec2_config" {
    description = "ec2 Configurations"
    type = map(string)
}
variable "rds" {
  description = "settings for RDS"
  type = object({
    identifier         = string
    engine             = string
    instance_class     = string
    engine_version     = string
    param_group_family = string
    db_name            = string
    db_user            = string
  })
}




variable "public_alb_conf" {
  type = object({
    alb_name                         = string
    tg_name                          = string
    internal                         = bool
    load_balancer_type               = string
    protocol                         = string
    target_type                      = string
    port                             = string
    health_check_path                = string
    health_check_port                = number
    health_check_protocol            = string
    health_check_interval            = number
    health_check_timeout             = number
    health_check_healthy_threshold   = number
    health_check_unhealthy_threshold = number
    health_check_matcher             = string
    listener_type                    = string
    lb_http_listener                 = map(any)
    lb_https_listener                = map(any)
  })

}
