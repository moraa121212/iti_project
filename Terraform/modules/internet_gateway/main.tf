resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"  
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_subnets" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public_rt.id
}
