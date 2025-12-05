# create ec2 instance
resource "aws_instance" "example" {
  ami           = "ami-026012a857b852da3" # Example AMI ID, replace with a valid one for your region
  instance_type = "t2.micro"
  region = var.region

  tags = {
    Name = "ExampleInstance1"
  }
}