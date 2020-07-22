resource "aws_lb_target_group" "nginx" {
	name     = "nginx"
	port     = 80
	protocol = "HTTP"
	vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
	
	health_check {
		interval            = 30
		path                = "/health_check"
		port                = "traffic-port"
		protocol            = "HTTP"
		timeout             = 10
		healthy_threshold   = 3
		unhealthy_threshold = 3
	}
	# ロードバランサー作成してから、ターゲットグループを設定する
	# ターゲットグループを設定してから、aws_ecs_serviceを起動する
	# この順番で起動しないとエラーになるため記述
	depends_on = [
		aws_lb.lb
	]
}

 
resource "aws_lb_target_group_attachment" "lb" {
	target_group_arn = aws_lb_target_group.nginx.arn
	target_id        = aws_instance.techbooklabov1_ec2.id
	port             = 80
}