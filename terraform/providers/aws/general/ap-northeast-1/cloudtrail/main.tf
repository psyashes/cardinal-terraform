####################################################################
# CloudTrail
####################################################################
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/cloudtrail"
  retention_in_days = var.cloudwatch_logs_retantion_days
}

resource "aws_iam_policy" "this" {
  name   = "${title(var.app_name)}CloudTrailPolicy"
  policy = data.aws_iam_policy_document.cloudtrail_policy.json
}

module "iam_role_cloudtrail" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "3.6.0"

  create_role       = true
  role_name         = "${title(var.app_name)}CloudTrailRole"
  role_requires_mfa = var.iam_role_cloudtrail["role_requires_mfa"]

  custom_role_policy_arns = [
    aws_iam_policy.this.arn
  ]

  trusted_role_services = [
    "cloudtrail.amazonaws.com"
  ]
}

resource "aws_cloudtrail" "this" {
  name                       = var.app_name
  s3_bucket_name             = "log-private-${var.s3_bucket}"
  cloud_watch_logs_role_arn  = module.iam_role_cloudtrail.this_iam_role_arn
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.this.arn}:*"
}
