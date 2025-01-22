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
