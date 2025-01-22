terraform {
  backend "s3" {
    bucket         = "ansys-terraform-state-bucket"
    key            = "ansys-vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ansys-lock-table"
    encrypt        = true
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  tags     = var.tags
}