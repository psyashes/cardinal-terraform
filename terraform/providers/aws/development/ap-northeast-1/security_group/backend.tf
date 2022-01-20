terraform {
  backend "s3" {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/development/ap-northeast-1/security_group.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/development/ap-northeast-1/vpc.tfstate"
    region = "ap-northeast-1"
  }
}
