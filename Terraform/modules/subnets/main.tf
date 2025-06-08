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
resource "aws_eip" "project_eip" {
  count = length(var.subnet_cidrs_pup) 
  vpc   = true
}
resource "aws_nat_gateway" "project_nat_gateway" {
  count         = length(var.subnet_cidrs_pup) 
  allocation_id = aws_eip.project_eip[count.index].id 
  subnet_id     = aws_subnet.project_subnet_puplic[count.index].id 
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "private_rt" {
  count  = length(var.subnet_cidrs_prv) 
  vpc_id = aws_vpc.main.id
}
resource "aws_route" "private_nat_gateway_route" {
  count                  = length(var.subnet_cidrs_prv) 
  route_table_id         = aws_route_table.private_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0" 
  nat_gateway_id         = aws_nat_gateway.project_nat_gateway[count.index].id 
  depends_on = [aws_nat_gateway.main]
}
resource "aws_route_table_association" "private_subnet_associations" {
  count          = length(var.subnet_cidrs_prv) 
  subnet_id      = aws_subnet.project_subnet_private[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id 
}
