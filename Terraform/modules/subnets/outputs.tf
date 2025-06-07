output "subnet_ids" {
  value = [for s in aws_subnet.project_subnet : s.id]
}
