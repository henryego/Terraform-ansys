variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "S3 bucket name for storing the Terraform state"
  type        = string
}

variable "state_dynamodb_table" {
  description = "DynamoDB table name for state locking"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "ansys"
  }
}

variable "public_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
  default     = 3
}

variable "private_subnet_count" {
  description = "Number of private subnets to create"
  type        = number
  default     = 3
}