resource "aws_security_group" "db-sg" {
	name        = "techbooklabov1-db-sg"
	description = "DB security group"
	vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

	ingress {
		from_port = 3306
		to_port   = 3306
		protocol   = "TCP"
		security_groups = [
			data.terraform_remote_state.service.outputs.instance_sg_id,
		]
	} 
}