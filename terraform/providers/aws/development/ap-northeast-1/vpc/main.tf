####################################################################
# VPC
####################################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"

  name                             = "development"
  cidr                             = var.vpc["cidr"]
  default_vpc_enable_dns_hostnames = true

  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnets  = var.vpc["public_subnets"]
  private_subnets = var.vpc["private_subnets"]
  azs             = var.vpc["azs"]

  map_public_ip_on_launch = false
}

resource "aws_iam_policy" "vpc_flow_log" {
  name   = "${title(var.app_name)}DevelopmentVPCFlowLogPolicy"
  policy = data.aws_iam_policy_document.vpc_flow_log_policy.json
}

module "iam_role_vpc_flow_log" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "3.16.0"

  create_role       = true
  role_name         = "${title(var.app_name)}DevelopmentVPCFlowLogRole"
  role_requires_mfa = var.iam_role_vpc_flow_log["role_requires_mfa"]

  trusted_role_services = [
    "vpc-flow-logs.amazonaws.com"
  ]

  custom_role_policy_arns = [
    aws_iam_policy.vpc_flow_log.arn
  ]
}

resource "aws_cloudwatch_log_group" "vpc_flow_log" {
  name              = "/aws/vpc/development-vpc-flow-log"
  retention_in_days = var.cloudwatch_logs_retantion_days
}

resource "aws_flow_log" "this" {
  iam_role_arn    = module.iam_role_vpc_flow_log.this_iam_role_arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_log.arn
  traffic_type    = "ALL"
  vpc_id          = module.vpc.vpc_id
}

####################################################################
# VPC endpoints
####################################################################
module "endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.6.0"

  vpc_id = module.vpc.vpc_id

  endpoints = {
    s3 = {
      route_table_ids = concat(
        module.vpc.private_route_table_ids,
        module.vpc.public_route_table_ids
      )
      service      = "s3"
      service_type = "Gateway"
    }
  }
}
