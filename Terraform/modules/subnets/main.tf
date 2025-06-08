resource "aws_subnet" "project_subnet_private" {
  for_each = zipmap(var.availability_zones, var.subnet_cidrs_prv)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
}
resource "aws_subnet" "project_subnet_puplic" {
  for_each = zipmap(var.availability_zones, var.subnet_cidrs_pup)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
}
resource "aws_eip" "nat" {
  count = length(var.subnet_cidrs_pup) 
  vpc   = true
}
