resource "aws_security_group_rule" "eks_worker_to_cluster_443" {
  type                     = "ingress" 
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = module.SG-worker.sg_nodes_ids
  security_group_id        = module.SG-control-plane.cluster_sg_ids
  description              = "Allow HTTPS from Worker SG to EKS Cluster SG"
}
resource "aws_security_group_rule" "eks_cluster_to_worker_443" {
  type                     = "ingress" 
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = module.SG-control-plane.cluster_sg_ids
  security_group_id        = module.SG-worker.sg_nodes_ids
  description              = "Allow HTTPS from EKS Cluster SG to Worker SG"
}
resource "aws_security_group_rule" "eks_cluster_to_worker_kubelet" {
  type                     = "ingress"
  from_port                = 10250 
  to_port                  = 65535 
  protocol                 = "tcp"
  source_security_group_id = module.SG-control-plane.cluster_sg_ids
  security_group_id        = module.SG-worker.sg_nodes_ids
  description              = "Allow Kubelet/NodePort traffic from EKS Cluster SG to Worker SG"
}
