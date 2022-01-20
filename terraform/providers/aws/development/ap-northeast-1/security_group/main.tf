####################################################################
# Security Group
####################################################################
resource "aws_default_security_group" "this" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

module "sg_internal" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name                = "development-internal"
  use_name_prefix     = false
  description         = "Managed by Terraform"
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress_cidr_blocks = var.sg_internal["ingress_cidr_blocks"]
  ingress_rules       = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
}
