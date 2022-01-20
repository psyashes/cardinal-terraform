####################################################################
# Security group
####################################################################
module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name            = "dev-ubuntu"
  use_name_prefix = false
  description     = "Managed by Terraform"
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = var.sg["ingress_cidr_blocks"]
  ingress_rules       = ["ssh-tcp"]

  egress_cidr_blocks = [
    "0.0.0.0/0",
  ]

  egress_rules = ["all-all"]
}

####################################################################
# EC2 - Instance
####################################################################
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name          = "dev-ubuntu"
  ami           = var.ec2["ami"]
  instance_type = var.ec2["instance_type"]
  key_name      = var.ec2_key_name
  monitoring    = true

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.sg_internal_id,
    module.sg.this_security_group_id,
  ]

  subnet_id                   = element(data.terraform_remote_state.vpc.outputs.public_subnets, 0)
  disable_api_termination     = true
  associate_public_ip_address = true
  user_data                   = data.template_cloudinit_config.config.rendered
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.iam_role_ec2_role_name

  volume_tags = {
    Backup = "true"
  }

  tags = {
    Environment = "development"
  }
}
