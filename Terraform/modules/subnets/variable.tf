variable "vpc_id" {
  description = "The VPC ID where subnets will be created"
  type        = string
}
variable "subnet_cidrs_prv" {
  type        = list(string)
  description = "List of subnet CIDRs"
}
variable "subnet_cidrs_pup" {
  type        = list(string)
  description = "List of subnet CIDRs"
}
variable "availability_zones" {
  type        = list(string)
  description = "List of AZs"
}
