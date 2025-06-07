variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM Role ARN to be used by the cluster"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.31"
}

variable "subnet_ids" {
  description = "List of Subnet IDs to launch EKS cluster in"
  type        = list(string)
}

variable "cluster_role_policy_attachment_depends_on" {
  description = "Optional: make the cluster wait for the IAM policy to attach"
  type        = list(any)
  default     = []
}
