variable "app_name" {}

variable "cloudwatch_logs_retantion_days" {}

variable "s3_bucket" {}

variable "iam_role_cloudtrail" {
  default = {
    role_requires_mfa = false
  }
}
