semantic_version = "1.0.0"
project_name  = "devops-assgn"

vpc = {
  name                   = "DevOps-Assgn-vpc"
  azs                    = ["us-west-2a", "us-west-2b"]
  cidr                   = "10.0.0.0/16"
  private_subnets        = ["10.0.0.0/24", "10.0.1.0/24"]
  public_subnets         = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway     = false
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
}
my_public_ip = "0.0.0.0/0"

rds = {
  identifier         = "devopsassgn"
  db_name            = "devopsassgnapp"
  db_user            = "devopsassgnuser"
  param_group_family = "mysql8.0"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  engine             = "mysql"
}


public_alb_conf = {
  alb_name                         = "public-lb"
  tg_name                          = "public-tg"
  internal                         = false
  load_balancer_type               = "application"
  protocol                         = "HTTP"
  target_type                      = "instance"
  port                             = "80"
  health_check_path                = "/"
  health_check_port                = 80
  health_check_protocol            = "HTTP"
  health_check_interval            = 60
  health_check_timeout             = 5
  health_check_healthy_threshold   = 5
  health_check_unhealthy_threshold = 2
  health_check_matcher             = "200-405"
  listener_type                    = "forward"
  lb_http_listener = {
  protocol                         = "HTTP"
  port                             = "80"
  listener_type                    = "redirect"
  status_code = "HTTP_301"
  }
  lb_https_listener = {
  protocol                         = "HTTPS"
  port                             = "443"
  listener_type                    = "forward"
  certificate_arn              =  "arn:aws:acm:us-west-2:489994096722:certificate/594c2234-c53a-4ea0-b448-8c9829a523b1"
  }
}

ec2_config = {

    cpu = "t2.micro"
    associate_public_ip_address = true
  
}