resource "aws_security_group" "worker_sg" {
  name        = var.sg_nodes
  description = "Security Group for EKS worker nodes"
  vpc_id      = var.vpc_id
  ingress {
    description = "Allow all traffic between worker nodes (Self-referencing SG)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    self        = true 
  }
  ingress {
    description = "Allow HTTP/HTTPS from ALB to worker nodes (for Pods)"
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic from worker nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
