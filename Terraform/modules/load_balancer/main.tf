resource "aws_lb" "lb" {
  name               = "${var.lb_conf.alb_name}-${terraform.workspace}"
  internal           = var.lb_conf.internal
  load_balancer_type = var.lb_conf.load_balancer_type
  security_groups    = var.sg_id
  subnets            = var.subnet_ids
}


resource "aws_lb_target_group" "lb_tg" {
  name        = "${var.lb_conf.tg_name}-${terraform.workspace}"
  protocol    = var.lb_conf.protocol
  vpc_id      = var.vpc_id
  target_type = var.lb_conf.target_type
  port        = var.lb_conf.port

  health_check {
    path                = var.lb_conf.health_check_path
    port                = var.lb_conf.health_check_port
    protocol            = var.lb_conf.health_check_protocol
    interval            = var.lb_conf.health_check_interval
    timeout             = var.lb_conf.health_check_timeout
    healthy_threshold   = var.lb_conf.health_check_healthy_threshold
    unhealthy_threshold = var.lb_conf.health_check_unhealthy_threshold
    matcher             = var.lb_conf.health_check_matcher
  }

}


resource "aws_lb_listener" "listener" {
  count       = var.lb_conf.lb_http_listener == null ? 1 : 0
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_conf.port
  protocol          = var.lb_conf.protocol

  default_action {
    type             = var.lb_conf.listener_type
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}

resource "aws_lb_listener" "http_listener" {
  count       = var.lb_conf.lb_http_listener == null ? 0 : 1
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_conf.lb_http_listener.port
  protocol          = var.lb_conf.lb_http_listener.protocol

  default_action {
    type             = var.lb_conf.lb_http_listener.listener_type
    redirect {
      port     = var.lb_conf.lb_https_listener.port
      protocol = var.lb_conf.lb_https_listener.protocol
      status_code = var.lb_conf.lb_http_listener.status_code
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  count       = var.lb_conf.lb_http_listener == null ? 0 : 1
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_conf.lb_https_listener.port
  protocol          = var.lb_conf.lb_https_listener.protocol
  certificate_arn  = var.lb_conf.lb_https_listener.certificate_arn
  default_action {
    target_group_arn = aws_lb_target_group.lb_tg.arn
    type             = var.lb_conf.lb_https_listener.listener_type
  }
}

