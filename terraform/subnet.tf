# Public Subnet Creation
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  count             = "${length(var.public_subnets_cidr)}"
  cidr_block        = "${var.public_subnets_cidr[count.index]}"
  availability_zone = "${var.availability_zone[count.index]}"
  map_public_ip_on_launch = true

  tags = {"Name":"${local.prefix}-public_subnet-${count.index + 1}"}
}

# Private Subnets Creation
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  count             = "${length(var.private_subnets_cidr)}"
  cidr_block        = "${var.private_subnets_cidr[count.index]}"
  availability_zone = "${var.availability_zone[count.index]}"
  map_public_ip_on_launch = false

  tags = {"Name":"${local.prefix}-private_subnet-${count.index + 1}"}
}

# # Create multiple subnets for the EKS cluster
# resource "aws_subnet" "subnets" {
#   count                   = length(var.subnet_cidrs)
#   vpc_id                  = aws_vpc.vpc.id
#   availability_zone       = element(var.availability_zone, count.index)
#   cidr_block              = element(var.subnet_cidrs, count.index)
#   map_public_ip_on_launch = count.index < 2 ? true : false

#   tags = {
#     #   Name = "${var.prefix}-${element(var.availability_zone, count.index)}" 
#     Name = count.index < 2 ? "${var.prefix}-public-subnet-${count.index + 1}" : "${var.prefix}-private-subnet-${count.index + 1}"
#   }
# }
