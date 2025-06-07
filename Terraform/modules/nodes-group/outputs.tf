output "node_group_name" {
  description = "Name of the created Node Group"
  value       = aws_eks_node_group.project-nodes.node_group_name
}

output "node_group_arn" {
  description = "ARN of the created Node Group"
  value       = aws_eks_node_group.project-nodes.arn
}

output "node_group_status" {
  description = "Current status of the Node Group"
  value       = aws_eks_node_group.project-nodes.status
}
