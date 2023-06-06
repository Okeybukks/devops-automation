# VPC Creation
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-main"})
  )
}

# Public Subnet Creation
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  count             = "${length(var.public_subnets_cidr)}"
  cidr_block        = "${var.public_subnets_cidr[count.index]}"
  availability_zone = "${var.availability_zone[count.index]}"
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-public_subnet-${count.index + 1}"})
  )
}

# Private Subnets Creation
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  count             = "${length(var.private_subnets_cidr)}"
  cidr_block        = "${var.private_subnets_cidr[count.index]}"
  availability_zone = "${var.availability_zone[count.index]}"
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-private_subnet-${count.index + 1}"})
  )
}


# Internet-Gateway Creation
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-igw"})
  )
}

# Elastic IP Creation
resource "aws_eip" "elastic_ip" {
  vpc      = true
  count    = "${length(var.public_subnets_cidr)}"

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-elastic_ip-${count.index + 1}"})
  )
}

# NAT Gateway Creation
resource "aws_nat_gateway" "nat_gateway" {
  count          = "${length(var.public_subnets_cidr)}"
  allocation_id  = aws_eip.elastic_ip[count.index].id
  subnet_id      = aws_subnet.public_subnet[count.index].id

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-nat_gw-${count.index + 1}"})
  )

  depends_on = [aws_internet_gateway.igw]
}

# Public route table Creation
resource "aws_route_table" "public_route_table" {
  vpc_id         = aws_vpc.main.id
  count          = "${length(var.public_subnets_cidr)}"

  route {
    cidr_block   = "0.0.0.0/0"
    gateway_id   = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-public_route_table-${count.index + 1}"})
  )
}

# Public route table association
resource "aws_route_table_association" "public_RT_association" {
  count          = "${length(var.public_subnets_cidr)}"
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table[count.index].id
}

# Private route table Creation
resource "aws_route_table" "private_route_table" {
  vpc_id            = aws_vpc.main.id
  count             = "${length(var.private_subnets_cidr)}"

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-private_route_table-${count.index + 1}"})
  )
}

# Private route table association
resource "aws_route_table_association" "private_RT_association" {
  count          = "${length(var.private_subnets_cidr)}"
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
