resource "aws_security_group" "instance_sg" {
	name        = "techbooklabov1_instance_sg"
	description = "instance security group"
	vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"

		security_groups = [aws_security_group.alb_sg.id]
	}  
}

resource "aws_security_group" "alb_sg" {
	name = "techbooklabov1-alb-sg"
	description = "http and https"
	vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]	
	}

	# HTTPSのアクセス許可
	ingress {
		from_port   = 443
		to_port     = 443
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]	
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
