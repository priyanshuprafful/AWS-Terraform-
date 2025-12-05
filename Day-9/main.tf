# create ec2 instance
resource "aws_instance" "example" {
  ami           = "ami-026012a857b852da3" # Example AMI ID, replace with a valid one for your region
  instance_type = var.instance_types[0]
  region = var.allowed_region[0]

  tags = var.tags

  lifecycle {
    create_before_destroy = false 
   # prevent_destroy = true
  }
} 

# ==============================
# Example 3: ignore_changes
# Use Case: Auto Scaling Group where capacity is managed externally
# ==============================

# Launch Template for Auto Scaling Group
resource "aws_launch_template" "app_server" {
  name_prefix   = "app-server-"
  image_id      = "ami-0fa3fe0fa7920f68e"
  instance_type = var.instance_types[0]

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
    
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_servers" {
  name               = "app-servers-asg"
  min_size           = 1
  max_size           = 5
  desired_capacity   = 2
  health_check_type  = "EC2"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "App Server ASG"
    propagate_at_launch = true
  }

  tag {
    key                 = "Demo"
    value               = "ignore_changes"
    propagate_at_launch = false
  }

  # Lifecycle Rule: Ignore changes to desired_capacity
  # This is useful when auto-scaling policies or external systems modify capacity
  # Terraform won't try to revert capacity changes made outside of Terraform
  lifecycle {
    ignore_changes = [
      desired_capacity,
      # Also ignore load_balancers if added later by other processes
    ]
  }
}



# ==============================
# Example 6: replace_triggered_by
# Use Case: Replace EC2 instances when security group changes
# ==============================

# Security Group
resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Security group for application servers"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = var.tags
  
}

# EC2 Instance that gets replaced when security group changes
resource "aws_instance" "app_with_sg" {
  ami                    = "ami-026012a857b852da3"
  instance_type          = var.instance_types[0]
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = var.tags

  # Lifecycle Rule: Replace instance when security group changes
  # This ensures the instance is recreated with new security rules
  lifecycle {
    replace_triggered_by = [
      aws_security_group.app_sg.id
    ]
  }
}







# ==============================
# Example 4: precondition
# Use Case: Ensure we're deploying in an allowed region
# ==============================

# resource "aws_s3_bucket" "regional_validation" {
#   bucket = "bucket-regional-validation-priyanshu69"

#   tags = var.tags

#   # Lifecycle Rule: Validate region before creating resource
#   # This prevents resource creation in unauthorized regions
#   lifecycle {
#     precondition {
#       condition     = contains(var.allowed_regions, data.aws_region.current.name)
#       error_message = "ERROR: This resource can only be created in allowed regions: ${join(", ", var.allowed_regions)}. Current region: ${data.aws_region.current.name}"
#     }
#   }
# }

# ==============================
# Example 5: postcondition
# Use Case: Ensure S3 bucket has required tags after creation
# ==============================

resource "aws_s3_bucket" "compliance_bucket" {
  bucket = "bucket-regional-validation-priyanshu69"

  tags = var.tags

  # Lifecycle Rule: Validate bucket has required tags after creation
  # This ensures compliance with organizational tagging policies
  lifecycle {
    postcondition {
      condition     = contains(keys(var.tags), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag for audit purposes!"
    }

    postcondition {
      condition     = contains(keys(var.tags), "Environment")
      error_message = "ERROR: Bucket must have an 'Environment' tag!"
    }
  }
}

