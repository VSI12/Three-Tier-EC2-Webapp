#VPC
resource "aws_vpc" "three-tier_vpc" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "three-tier-vpc"
  }
}
#interget gateway to give vpc internet access
resource "aws_internet_gateway" "three-tier_igw" {
  vpc_id = aws_vpc.three-tier_vpc.id

  tags = {
    Name = "three-tier-igw"
  }
}

  resource "aws_route" "three-tier_route" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier_igw.id
    route_table_id = aws_vpc.three-tier_vpc.main_route_table_id
  }

  #PUBLIS SUBNETS
  resource "aws_subnet" "three-tier_public_subnet-a" {
    vpc_id = aws_vpc.three-tier_vpc.id
    cidr_block = "10.2.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "three-tier-public-subnet-a"
    }
  }
    resource "aws_subnet" "three-tier_public_subnet-b" {
    vpc_id = aws_vpc.three-tier_vpc.id
    cidr_block = "10.2.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
      Name = "three-tier-public-subnet-b"
    }
  }



#PRIVATE SUBNETS
resource "aws_subnet" "three-tier_private_subnet-a" {
    vpc_id = aws_vpc.three-tier_vpc.id
    cidr_block = "10.2.3.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "three-tier-private-subnet-a"
    }
  }
resource "aws_subnet" "three-tier_private_subnet-b" {
    vpc_id = aws_vpc.three-tier_vpc.id
    cidr_block = "10.2.4.0/24"
    availability_zone = "us-east-1b"

    tags = {
      Name = "three-tier-private-subnet-b"
    }
  }

  resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.three-tier_vpc.id

    tags = {
      Name = "three-tier-private-route-table"
    }
  }

  resource "aws_route_table_association" "private-a" {
    subnet_id = aws_subnet.three-tier_private_subnet-a.id
    route_table_id = aws_route_table.private_route_table.id
  }

  resource "aws_route_table_association" "private-b" {
    subnet_id = aws_subnet.three-tier_private_subnet-b.id
    route_table_id = aws_route_table.private_route_table.id
  }