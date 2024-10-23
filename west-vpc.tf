# VPC definition in eu-west-1 region (West VPC)
resource "aws_vpc" "west_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "west_vpc"
  }
} # Create West VPC, will act as a network container for migration of On-prem Resources

# Subnet for VPC
resource "aws_subnet" "west_subnet" {
  vpc_id            = aws_vpc.west_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"  # Adjust as needed
} # Create more subnets later for resource management

# Internet Gateway
resource "aws_internet_gateway" "west_igw" {
  vpc_id = aws_vpc.west_vpc.id
}

# Route Table for VPC
resource "aws_route_table" "west_route_table" {
  vpc_id = aws_vpc.west_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.west_igw.id
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "west_route_table_association" {
  subnet_id      = aws_subnet.west_subnet.id
  route_table_id = aws_route_table.west_route_table.id
}

# VPN Gateway for the West VPC
resource "aws_vpn_gateway" "west_vpn_gateway" {
  vpc_id = aws_vpc.west_vpc.id
  amazon_side_asn = "65000"
}