data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "nakano-terraform.tfstate"
    key    = "benchmap/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}