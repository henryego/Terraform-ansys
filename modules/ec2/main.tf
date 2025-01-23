resource "aws_security_group" "nginx_sg" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    var.tags,
    { Name = "nginx-sg" }
  )
}


resource "aws_instance" "public" {
  for_each = { for id, subnet_id in var.public_subnet_ids : id => subnet_id }
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = each.value
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true

  tags = merge(
    var.tags,
    { Name = "Public-EC2-${each.key}" }
  )
}


resource "aws_instance" "private" {
  for_each = { for id, subnet_id in var.private_subnet_ids : id => subnet_id }

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = each.value
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = false

  tags = merge(
    var.tags,
    { Name = "Private-EC2-${each.key}" }
  )
}

data "aws_ami" "myami" {
  most_recent      = true
  owners           = ["099720109477"]

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
