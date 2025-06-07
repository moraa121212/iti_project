variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "control_plane_cidr_blocks" {
  description = "List of CIDR blocks allowed to access control plane"
  type        = list(string)
}
