terraform {
  backend "s3" {

    bucket = "aws-terraform-prafful-bucket-with-state"
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




# create s3 bucket
resource "aws_s3_bucket" "my_bucket_two" {
  bucket = "aws-terraform-prafful-bucket-with-state"
  

  tags = {
    Name        = "TerraformExampleBucket-with-state"
    Environment = "Dev"
  }
}
# s3 bucket needs to be globally unique so append random string