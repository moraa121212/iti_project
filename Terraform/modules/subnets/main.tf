resource "aws_subnet" "project_subnet" {
  for_each = zipmap(var.availability_zones, var.subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
}
