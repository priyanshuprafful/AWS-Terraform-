# create an ec2 instance
resource "aws_instance" "example" {
  
  count = var.instance_count
  ami           = "ami-026012a857b852da3" # RHEL 9 AMI in us-east-1
  instance_type = "t2.micro"
  region = var.region

  tags = {
    environment = var.environment
    Name = "${var.environment}-EC2-instance"
  }
}