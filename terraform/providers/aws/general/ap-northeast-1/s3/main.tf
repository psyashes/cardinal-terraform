####################################################################
# S3
####################################################################
module "s3_log_private" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v1.25.0"

  bucket        = "log-private-${var.s3_bucket}"
  attach_policy = true
  policy        = data.aws_iam_policy_document.log_private.json

  lifecycle_rule = [{
    enabled = true
    expiration = {
      days = var.s3_lifecycle_expiration_days
    }
  }]

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = {
    PublicReadProhibitedTarget = "true"
  }
}
