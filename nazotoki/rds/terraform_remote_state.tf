data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "nakano-terraform.tfstate"
    key    = "nazotoki/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}