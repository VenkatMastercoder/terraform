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

resource "aws_instance" "instance_creation" {
  ami           = "ami-0199ac7c9fbf9ed83"
  instance_type = "t3.small"

  tags = {
    Name = "terrafrom-ec2-dev"
  }
}