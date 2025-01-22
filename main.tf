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

module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  vpc_cidr             = var.vpc_cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  tags                 = var.tags
}