output "output" {
  value = {
    tg_arn = aws_lb_target_group.lb_tg.arn
    dns    = aws_lb.lb.dns_name
  }
}


