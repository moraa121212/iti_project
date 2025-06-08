resource "aws_subnet" "project_subnet-private" {
  for_each = zipmap(var.availability_zones, var.subnet_cidrs-prv)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
}
resource "aws_subnet" "project_subnet-puplic" {
  for_each = zipmap(var.availability_zones, var.subnet_cidrs-pup)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
}
