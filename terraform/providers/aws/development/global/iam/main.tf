####################################################################
# IAM - Policy
####################################################################
resource "aws_iam_policy" "ec2" {
  name   = "${title(var.app_name)}DevelopmentEC2Policy"
  policy = data.aws_iam_policy_document.ec2_policy.json
}

####################################################################
# IAM - Role
####################################################################
module "iam_role_ec2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "3.16.0"

  create_role             = true
  create_instance_profile = true
  role_name               = "${title(var.app_name)}DevelopmentEC2Role"
  role_requires_mfa       = var.iam_role_ec2["role_requires_mfa"]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    aws_iam_policy.ec2.arn
  ]
}
