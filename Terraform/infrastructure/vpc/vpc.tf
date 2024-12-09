#VPC
resource "aws_vpc" "three-tier_vpc" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    name = "three-tier-vpc"
  }
}
#interget gateway to give vpc internet access
resource "aws_internet_gateway" "three-tier_igw" {
  vpc_id = aws_vpc.three-tier_vpc.id

  tags = {
    name = "three-tier-igw"
  }
}

resource "aws_internet_gateway_attachment" "three-tier_igw" {
  internet_gateway_id = aws_internet_gateway.three-tier_igw.id
  vpc_id              = aws_vpc.three-tier_vpc.id
}