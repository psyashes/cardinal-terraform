variable "sg_internal" {
  default = {
    ingress_cidr_blocks = ["172.30.0.0/16"]
  }
}
