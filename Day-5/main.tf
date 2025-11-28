terraform {
  backend "s3" {

    bucket =  "aws-terraform-prafful-bucket"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
    
  }
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

variable "environment" {

  default = "dev"
  type = string
  
}

variable "region" {
  default = "us-east-1"
  type = string
  
}

locals {
  vpc1 = "TerraformExampleVPC"
}

# create a vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  region = var.region
  tags = {
    Name        = "${local.vpc1}-${var.environment}"
    Environment = var.environment
  }
}