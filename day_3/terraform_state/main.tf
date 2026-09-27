terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.66.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-file-test-b6"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-2"
    use_lockfile   = true
    encrypt        = true
    force_destroy  = true
  }
}

provider "aws" {
  region = "ap-south-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-file-test-b6"

  force_destroy = true

  tags = {
    Name = "Terraform State Bucket"
  }
}

resource "aws_instance" "instance_creation" {
  ami           = "ami-0199ac7c9fbf9ed83"
  instance_type = "t3.micro"

  tags = {
    Name = "terrafrom-ec2-state_files"
  }
}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Locks"
  }
}