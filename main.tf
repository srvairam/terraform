#Version of the terraform
terraform {
  required_version = ">= 0.12"
}

#Define provider here
provider "aws" {
  region = var.AWS_REGION
}



# Define VPC
resource "aws_vpc" "main-terrraform-vpc" {
  cidr_block           = "${var.VPC_CIDR}"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main-terrraform-vpc"
  }
}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main-terrraform-vpc.id
  cidr_block              = "${var.PUB_CIDR}"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
	
  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main-terrraform-vpc.id
  cidr_block              = var.PVT_CIDR
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = aws_vpc.main-terrraform-vpc.id
  cidr_block              = var.PVT2_CIDR
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "main-private-2"
  }
}

#resource "aws_db_subnet_group" "my-rds-db-subnet" {
#  name       = "my-rds-db-subnet"
#  subnet_ids = [aws_subnet.main-private-1.id,aws_subnet.main-private-2.id]
#}


# Internet GW
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-terrraform-vpc.id

  tags = {
    Name = "main-igw"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main-terrraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

#AWS Keypair to connect to aws ec2
resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

