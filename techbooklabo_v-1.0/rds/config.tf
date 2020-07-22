provider "aws" {
	region = "ap-northeast-1"
}

terraform {
	backend "s3" {
		bucket = "techbooklabo-v-1.0-tfstate"
		key    = "techbooklabo_v-1.0/rds/terraform.tfstate"
		region = "ap-northeast-1"
	}
}