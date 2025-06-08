output "subnet_ids_prv" {
  value = [for s in aws_subnet.project_subnet_private : s.id]
}
output "subnet_ids_pup" {
  value = [for s in aws_subnet.project_subnet_puplic : s.id]
}
