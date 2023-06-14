##########################################
# VPC 
##########################################
resource "aws_vpc" "flutt_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "flutter-vpc"
  }
}

##########################################
# Public Subnets 
##########################################

resource "aws_subnet" "public_sub1" {
  vpc_id            = aws_vpc.flutt_vpc.id
  cidr_block        = var.cidr_ranges.pub_sub1
  availability_zone = "eu-west-1a"
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "public_sub2" {
  vpc_id            = aws_vpc.flutt_vpc.id
  cidr_block        = var.cidr_ranges.pub_sub2
  availability_zone = "eu-west-1b"
  tags = {
    Name = "public-subnet2"
  }
}
##########################################
# Private Subnets 
##########################################

resource "aws_subnet" "private_sub1" {
  vpc_id            = aws_vpc.flutt_vpc.id
  cidr_block        = var.cidr_ranges.prvt_sub1
  availability_zone = "eu-west-1a"
  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private_sub2" {
  vpc_id            = aws_vpc.flutt_vpc.id
  cidr_block        = var.cidr_ranges.prvt_sub2
  availability_zone = "eu-west-1b"
  tags = {
    Name = "private-subnet2"
  }
}
##########################################
# Internet gateway
##########################################
resource "aws_internet_gateway" "flutt_igw" {
  vpc_id = aws_vpc.flutt_vpc.id
  tags = {
    Name = "flutter-igw"
  }
}
##########################################
# Routing tables
##########################################
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.flutt_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.flutt_igw.id
  }

  tags = {
    Name = "RT-1"
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.flutt_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.flutt_igw.id
  }

  tags = {
    Name = "RT-2"
  }
}

resource "aws_route_table" "rt3" {
  vpc_id = aws_vpc.flutt_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }

  tags = {
    Name = "RT-3"
  }
}

resource "aws_route_table" "rt4" {
  vpc_id = aws_vpc.flutt_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat2.id
  }

  tags = {
    Name = "RT-4"
  }
}
##########################################
# Elastic IPs
##########################################
resource "aws_eip" "nat_eip_public1" {
  domain = "vpc"
}

resource "aws_eip" "nat_eip_public2" {
  domain = "vpc"
}

##########################################
# NATs
##########################################

resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat_eip_public1.id
  subnet_id     = aws_subnet.public_sub1.id

  tags = {
    Name = "NAT-1"
  }
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.nat_eip_public2.id
  subnet_id     = aws_subnet.public_sub2.id

  tags = {
    Name = "NAT-2"
  }
}
##########################################
# Route Table Associations
##########################################
resource "aws_route_table_association" "public_route_association1" {
  subnet_id      = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "public_route_association2" {
  subnet_id      = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.rt2.id
}

resource "aws_route_table_association" "private_route_association3" {
  subnet_id      = aws_subnet.private_sub1.id
  route_table_id = aws_route_table.rt3.id
}

resource "aws_route_table_association" "private_route_association4" {
  subnet_id      = aws_subnet.private_sub2.id
  route_table_id = aws_route_table.rt4.id
}
