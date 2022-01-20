variable "app_name" {}

variable "s3_bucket" {}

variable "iam_role_ec2" {
  default = {
    role_requires_mfa = false
  }
}
