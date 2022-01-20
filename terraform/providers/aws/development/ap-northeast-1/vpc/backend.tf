terraform {
  backend "s3" {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/development/ap-northeast-1/vpc.tfstate"
    region = "ap-northeast-1"
  }
}

data "aws_iam_policy_document" "vpc_flow_log_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}
