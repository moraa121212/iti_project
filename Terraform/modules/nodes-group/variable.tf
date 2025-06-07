variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the Node Group"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role for the Node Group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch the nodes in"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_unavailable" {
  description = "Maximum number of nodes unavailable during update"
  type        = number
  default     = 1
}

variable "instance_types" {
  description = "List of EC2 instance types for the nodes"
  type        = list(string)
}

variable "ami_type" {
  description = "AMI type for the nodes"
  type        = string
  default     = "AL2_x86_64"
}

variable "depends_on_resources" {
  description = "List of resources this node group depends on"
  type        = list(any)
  default     = []
}
