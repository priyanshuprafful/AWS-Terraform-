terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
   }
 }
}

# Configure the AWS Provider

provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
  }

}

