output "role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}
output "cluster_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.cluster_policy_attachment
}
