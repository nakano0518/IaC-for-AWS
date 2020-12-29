# リスナールール: ALBが1つ以上のターゲットグループ内のターゲットにリクエストをルーティングする方法
resource "aws_lb_listener_rule" "benchmap" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.benchmap.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}