provider "aws" {
  region = "us-east-1" # Specify your desired region
}

# variables

resource "aws_vpc" "terraform_VPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform_VPC"
  }
}

# Create Subnets
resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.terraform_VPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" # Specify the desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.terraform_VPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b" # Specify the desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_b"
  }
}

# Create Route Table
resource "aws_route_table" "terraform_route_table" {
  vpc_id = aws_vpc.terraform_VPC.id

  tags = {
    Name = "terraform_route_table"
  }
}

# Create Route Table Association
resource "aws_route_table_association" "subnet_a_association" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.terraform_route_table.id
}

resource "aws_route_table_association" "subnet_b_association" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.terraform_route_table.id
}

resource "aws_internet_gateway" "terraform_IGW" {
  vpc_id = aws_vpc.terraform_VPC.id

  tags = {
    Name = "terraform_IGW"
  }
}