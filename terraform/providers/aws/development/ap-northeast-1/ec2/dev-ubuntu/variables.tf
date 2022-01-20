variable "s3_bucket" {}

variable "ec2_key_name" {}

variable "sg" {
  default = {
    ingress_cidr_blocks = [
      "100.66.139.30/32",
      "52.196.85.114/32"
    ]
  }
}

variable "ec2" {
  default = {
    ami           = "ami-09c48a5d777342713"
    instance_type = "t3.xlarge"
  }
}
