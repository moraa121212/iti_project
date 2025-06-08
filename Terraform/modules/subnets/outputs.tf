output "subnet_ids_prv" {
  value = [for s in aws_subnet.project_subnet-private : s.id]
}
output "subnet_ids_pup" {
  value = [for s in aws_subnet.project_subnet-puplic : s.id]
}
