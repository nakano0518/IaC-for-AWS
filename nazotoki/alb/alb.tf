resource "aws_lb" "alb" {
	name = "nazotoki_alb"
	load_balancer_type = "application"
	internal = false
	idle_timeout = 60				  # タイムアウト(デフォルトは60)
	enable_deletion_protection = true # 削除保護

	subnets = {
		data.terraform_remote_state.vpc.outputs.public_subnet_1_id
	}

	access_log {
		bucket = data.terraform_remote_state.vpc.outputs.alb_log_bucket_id
		enabled = true
	}

	security_groups = [
		data.terraform_remote_state.vpc.outputs.security_group_alb_id
	]
}