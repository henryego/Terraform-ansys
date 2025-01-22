terraform {
  backend "s3" {
    bucket         = "ansys-terraform-state-bucket"
    key            = "ansys-vpc/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "ansys-lock-table"
    encrypt        = true
  }
}