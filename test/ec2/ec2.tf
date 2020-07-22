provider "aws" {
	region = "ap-northeast-1"
}

resource "aws_instance" "sample" {
	ami           = "ami-785c491f"
	instance_type = "t2.micro"
	subnet_id     = "${data.terraform_remote_state.vpc.outputs.public_subnet_id}" 
}

data "terraform_remote_state" "vpc" {
	backend = "s3"
	config  = {
		bucket = "test--tfstate"
		key    = "test/vpc/terraform.tfstate"
		region = "ap-northeast-1"
	}
}

terraform {
	backend "s3" {
		bucket = "test--tfstate"
		key    = "test/ec2/terraform.tfstate"
		region = "ap-northeast-1"
	}
}