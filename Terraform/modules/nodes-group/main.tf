resource "aws_eks_node_group" "project-nodes" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids_prv
 security_group_ids = [ module.SG.worker_sg_id ]
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  instance_types = var.instance_types
  ami_type       = var.ami_type
}
  
