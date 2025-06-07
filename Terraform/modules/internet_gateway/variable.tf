variable "vpc_id" {
  description = "VPC ID to attach the Internet Gateway and Route Table"
  type        = string
}
variable "public_subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
