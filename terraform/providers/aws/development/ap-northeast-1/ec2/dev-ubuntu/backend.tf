terraform {
  backend "s3" {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/development/ap-northeast-1/ec2/dev-ubuntu.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/development/global/iam.tfstate"
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

data "terraform_remote_state" "security_group" {
  backend = "s3"

  config = {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/development/ap-northeast-1/security_group.tfstate"
    region = "ap-northeast-1"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "cloud-init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("../../../../templates/cloud-init.cfg", {})
  }
}
