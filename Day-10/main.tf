# create ec2 instance
resource "aws_instance" "example" {
  ami           = "ami-026012a857b852da3" # Example AMI ID, replace with a valid one for your region
  instance_type = var.environment == "dev" ? "t2.micro" : "t2.medium"
  region = var.region
  count = var.instance_count

  tags = var.tags
}