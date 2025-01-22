terraform {
  backend "s3" {
    bucket         = "ansys-terraform-state-bucket"
    key            = "ansys-vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ansys-lock-table"
    encrypt        = true
  }
}