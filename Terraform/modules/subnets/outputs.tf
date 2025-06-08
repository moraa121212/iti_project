output "subnet_ids_prv" {
  value = [for s in aws_subnet.project_subnet_prv : s.id]
}
output "subnet_ids_pup" {
  value = [for s in aws_subnet.project_subnet_pup : s.id]
}
