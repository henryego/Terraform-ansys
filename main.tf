terraform {
  backend "s3" {
    bucket         = "ansys-terraform-state-bucket"
    key            = "ansys-vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ansys-lock-table"
    encrypt        = true
  }
}

data "aws_ami" "myami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  tags     = var.tags
}

module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  igw_id               = module.subnets.igw_id
  tags                 = var.tags
}

module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
  ami_id             = data.aws_ami.myami.id
  instance_type      = var.instance_type
  tags               = var.tags
  ingress_rules      = var.ingress_rules
  egress_rules       = var.egress_rules
}
