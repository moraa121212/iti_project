output "cluster_sg_ids" {
  description = "The ID of the EKS cluster control plane security group."
  value       = aws_security_group.cluster_sg.id
}
