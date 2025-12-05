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




# create s3 bucket
resource "aws_s3_bucket" "my_bucket_one" {
  bucket = "aws-terraform-prafful-bucket"
  

  tags = {
    Name        = "TerraformExampleBucket"
    Environment = "Dev"
  }
}
# s3 bucket needs to be globally unique so append random string