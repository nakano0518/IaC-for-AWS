data "terraform_remote_state" "vpc" {
	backend = "s3"
	config = {
		bucket = "techbooklabo-v-1.0-tfstate"
		key = "techbooklabo_v-1.0/vpc/terraform.tfstate"
		region = "ap-northeast-1"
	}
}

data "terraform_remote_state" "service" {
	backend = "s3"
	config = {
		bucket = "techbooklabo-v-1.0-tfstate"
		key = "techbooklabo_v-1.0/service/terraform.tfstate"
		region = "ap-northeast-1"
	}
}