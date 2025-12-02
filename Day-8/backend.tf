terraform {
  backend "s3" {

    bucket =  "aws-terraform-prafful-bucket"
    key = "dev/day-6/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
    
  }
}