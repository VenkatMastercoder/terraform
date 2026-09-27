terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.66.0"
    }
  }
}

provider "aws" {
   region = "ap-south-2"
}

# 1. VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-vpc" 
  }
}

# 2. Public Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id # Reference to the VPC - Interpolation
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-public-subnet"
  }
}

# 3. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id # Interpolation
 
  tags = {
    Name = "terraform-igw"
  }
}

# 4. Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-route-table"
  }
}

# 5. Route Table Association
resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.route_table.id
}

# 6. Security Group
resource "aws_security_group" "sg" {
  name = "terraform-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform-sg"
  }
}

# 7. EC2 Instance 
resource "aws_instance" "example" {
  ami           = "ami-0199ac7c9fbf9ed83"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.main.id

  vpc_security_group_ids = [ aws_security_group.sg.id ]

  tags = {
    Name = "terraform-ec2"
  }
}