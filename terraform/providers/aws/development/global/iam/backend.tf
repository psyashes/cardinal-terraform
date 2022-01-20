terraform {
  backend "s3" {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/development/global/iam.tfstate"
    region = "ap-northeast-1"
  }
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    actions = [
      "ec2:CreateTags",
      "ec2:DescribeInstances",
    ]

    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::private-${var.s3_bucket}",
      "arn:aws:s3:::private-${var.s3_bucket}/*"
    ]

    effect = "Allow"
  }
}
