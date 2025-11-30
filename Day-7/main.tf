# create an ec2 instance
resource "aws_instance" "example" {
  
  count = 1
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  region = var.region

  tags = {
    environment = var.environment
    Name = "${var.environment}-EC2-instance"
  }
}