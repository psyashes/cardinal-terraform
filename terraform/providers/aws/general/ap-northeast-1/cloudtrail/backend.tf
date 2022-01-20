terraform {
  backend "s3" {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/general/ap-northeast-1/cloudtrail.tfstate"
    region = "ap-northeast-1"
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "cloudtrail_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["${aws_cloudwatch_log_group.this.arn}:log-stream:${data.aws_caller_identity.current.account_id}_CloudTrail_ap-northeast-1*"]
    effect    = "Allow"
  }
}
