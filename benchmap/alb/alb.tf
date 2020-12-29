resource "aws_lb" "alb" {
	name = "benchmap-alb"
	load_balancer_type = "application"
	internal = false
	# タイムアウト(デフォルトは60)
	idle_timeout = 60
	# 削除保護
	enable_deletion_protection = false

	subnets = [
		data.terraform_remote_state.vpc.outputs.public_subnet_1_id,
		data.terraform_remote_state.vpc.outputs.public_subnet_2_id,
	]

	access_logs {
		bucket = data.terraform_remote_state.s3.outputs.alb_log_bucket_id
		enabled = true
	}

	security_groups = [
		data.terraform_remote_state.vpc.outputs.security_group_alb_id
	]
}