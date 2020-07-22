# リスナールール: ALBが1つ以上のターゲットグループ内のターゲットにリクエストをルーティングする方法
resource "aws_lb_listener_rule" "nazotoki" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nazotoki.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}