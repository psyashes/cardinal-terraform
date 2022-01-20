variable "app_name" {}

variable "cloudwatch_logs_retantion_days" {}

variable "vpc" {
  default = {
    cidr            = "172.30.0.0/16"
    public_subnets  = ["172.30.64.0/24", "172.30.65.0/24"]
    private_subnets = ["172.30.68.0/24", "172.30.69.0/24"]
    azs             = ["ap-northeast-1a", "ap-northeast-1c"]
  }
}

variable "iam_role_vpc_flow_log" {
  default = {
    role_requires_mfa = false
  }
}
