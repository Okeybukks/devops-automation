# Create a VPC for the EKS cluster
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.prefix}-eks-vpc"
  }

}

# Create an internet gateway for the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-eks-igw"
  }
}


# Create a route table for the VPC
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-eks-route-table"
  }
}

# Create a route to the internet gateway
resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [aws_internet_gateway.igw]
}

# Associate the route table with the subnets
resource "aws_route_table_association" "route_table_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.route_table.id

  depends_on = [aws_route.route]
}

