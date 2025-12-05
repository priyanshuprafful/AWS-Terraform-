# create ec2 instance
resource "aws_instance" "example" {
  ami           = "ami-026012a857b852da3" # Example AMI ID, replace with a valid one for your region
  instance_type = var.instance_types[0]
  region = var.allowed_region[1]

  tags = var.tags

  lifecycle {
    create_before_destroy = true 
  }
} 