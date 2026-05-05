# 1. VPC Creation
# Define a private virtual network isolated from the internet
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  
  tags = {
    Name        = "fluxio-vpc"
    Environment = "Dev"
    Project     = "Data-Ops-Foundation"
  }
}

# 2. Private Subnet for Database
# Isolated subnet for RDS PostgreSQL instance, no direct public access
resource "aws_subnet" "private_db" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  
  tags = {
    Name        = "fluxio-private-db"
    Environment = "Dev"
  }
}

# 3. Public Subnet (Optional - for Bastion or NAT Gateway)
# Necessary if you need to reach the private DB from outside later
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.100.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "fluxio-public-subnet"
    Environment = "Dev"
  }
}
