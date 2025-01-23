variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default = "dev-vpc"
}
