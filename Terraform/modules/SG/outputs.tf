output "worker_sg_id" {
  description = "ID of the worker node security group"
  value       = aws_security_group.eks_worker_sg.id
}
