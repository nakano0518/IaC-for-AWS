resource "aws_ecs_service" "techbooklabov1_ecs_service" {
	name            = "techbooklabov1_ecs_service"
	cluster         = aws_ecs_cluster.techbooklabov1-ecs-cluster.id
	task_definition = aws_ecs_task_definition.techbooklabov1_task.arn
	desired_count   = 1
	launch_type     = "EC2"

	depends_on      = [
		aws_lb_target_group.nginx
	]

	load_balancer {
		target_group_arn = aws_lb_target_group.nginx.arn
		container_name   = "nginx"
		container_port   = 80
	}
}