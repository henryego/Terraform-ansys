data "aws_availability_zones" "available" {}

resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  tags = merge(
    var.tags,
    { Name = "public-subnet-${count.index + 1}" }
  )
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + var.public_subnet_count)
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  tags = merge(
    var.tags,
    { Name = "private-subnet-${count.index + 1}" }
  )
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-Public-RT"
  }
}

resource "aws_route_table_association" "public" {
  for_each = { for id, subnet in aws_subnet.public : id => subnet }
  subnet_id     = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-Private-RT"
  }
}

resource "aws_route_table_association" "private" {
  for_each = { for id, subnet in aws_subnet.private : id => subnet }
  subnet_id     = each.value.id
  route_table_id = aws_route_table.private.id
}



resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}
