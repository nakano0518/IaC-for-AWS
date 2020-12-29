data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "nakano-terraform.tfstate"
    key    = "benchmap/s3/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "nakano-terraform.tfstate"
    key    = "benchmap/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}