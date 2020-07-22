# albがどのprotocol, portで待ち受けるか
resource "aws_lb_listener" "lb" {
	load_balancer_arn = aws_lb.lb.arn
	port              = 443
	protocol          = "HTTPS"
	ssl_policy        = "ELBSecurityPolicy-2015-05"
	certificate_arn   = aws_acm_certificate.techbooklabov1_ssl.arn

	default_action {
		target_group_arn = aws_lb_target_group.nginx.arn
		type             =  "forward"
	}
}