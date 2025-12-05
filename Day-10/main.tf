# create ec2 instance
resource "aws_instance" "example" {
  ami           = "ami-026012a857b852da3" # Example AMI ID, replace with a valid one for your region
  instance_type = var.environment == "dev" ? "t2.micro" : "t2.medium"
  region = var.region
  count = var.instance_count

  tags = var.tags
}

# create security group
resource "aws_security_group" "example_sg" {
  name        = "example_sg_${var.environment}"
  description = "Example security group for ${var.environment} environment"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}