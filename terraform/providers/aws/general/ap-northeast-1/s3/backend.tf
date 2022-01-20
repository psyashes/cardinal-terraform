terraform {
  backend "s3" {
    bucket = "private-cardinal"
    key    = "terraform/providers/aws/general/ap-northeast-1/s3.tfstate"
    region = "ap-northeast-1"
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "log_private" {
  statement {
    actions = [
      "s3:*"
    ]

    effect = "Deny"

    resources = [
      "arn:aws:s3:::log-private-${var.s3_bucket}",
      "arn:aws:s3:::log-private-${var.s3_bucket}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false",
      ]
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::log-private-${var.s3_bucket}",
    ]

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
        "logs.amazonaws.com",
      ]
    }
  }

  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::log-private-${var.s3_bucket}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
        "logs.amazonaws.com",
      ]
    }
  }

  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::log-private-${var.s3_bucket}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:Referer"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }

    principals {
      type = "Service"

      identifiers = [
        "ses.amazonaws.com",
      ]
    }
  }
}
