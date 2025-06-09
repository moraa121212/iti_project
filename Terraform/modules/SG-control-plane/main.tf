resource "aws_security_group" "cluster_sg" {
  name        = var.sg_conrol_plane
  description = "Security Group for EKS Cluster control plane communication"
  vpc_id      = var.vpc_id
  egress {
    description = "Allow Control Plane to reach out to the internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
