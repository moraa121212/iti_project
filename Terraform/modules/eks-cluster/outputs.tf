output "cluster_name" {
  value = aws_eks_cluster.project-cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.project-cluster.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.project-cluster.certificate_authority[0].data
}
