# create a vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  region = var.region
  tags = {
    Name        = "${local.vpc1}-${var.environment}"
    Environment = var.environment
  }
}

