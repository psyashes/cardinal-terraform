output "iam_policy_ec2_arn" {
  value = aws_iam_policy.ec2.arn
}

output "iam_role_ec2_role_name" {
  value = module.iam_role_ec2.this_iam_role_name
}
