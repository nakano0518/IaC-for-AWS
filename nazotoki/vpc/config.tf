provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

terraform {
  required_version = "= 0.12.28"
}

terraform {
  backend "s3" {
    bucket = "nakano-terraform.tfstate"
    key    = "nazotoki/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}