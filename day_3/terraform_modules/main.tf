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

module "aws_s3_bucket_1" {
  source = "./modules/s3"
  bucket_name = "my-b6-demo-bucket-1"
}

module "aws_s3_bucket_2" {
  source = "./modules/s3"
  bucket_name = "my-b6-demo-bucket-2"
}

module "ec2_instance_1" {
  source = "./modules/ec2"
  instance_type = "t3.micro"
}