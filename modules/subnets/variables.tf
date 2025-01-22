variable "vpc_id" {
  description = "VPC ID where the subnets will be created"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
}

variable "private_subnet_count" {
  description = "Number of private subnets to create"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the subnets"
  type        = map(string)
}