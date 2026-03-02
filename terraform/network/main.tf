# provider configuration
provider "aws" {
  region = var.region
}

# VPC Resource
resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_block

    tags = {
        Name = "my_vpc"
    }
  
}

data "aws_availability_zones" "available" {}

#public subnet
resource "aws_subnet" "public" {
    count = var.subnet_count
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone =  element(data.aws_availability_zones.available.names, count.index)
    tags = {
        Name = "${var.subnet_name_prefix}_public_subnet_${count.index}"
    }

}

# Private Subnets
resource "aws_subnet" "private" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.subnet_name_prefix}-private-${count.index}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = var.gateway_name
    }
}

#Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.public.id

    tags = {
        Name = var.nat_gateway_name
    }
}

#public route table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route = {
        cidr_block = var.rt_public_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public_rt"
    }   
}

#private route table
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route = {
        cidr_block = var.rt_private_cidr
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = "private_rt"
    }   
}

# Associate Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Associate Private Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}