# create ec2 instance
resource "aws_instance" "example" {
  ami           = "ami-0fa3fe0fa7920f68e" # Example AMI ID, replace with a valid one for your region
  instance_type = var.instance_types[0]
  region = var.allowed_region[1]

  tags = var.tags

  lifecycle {
    create_before_destroy = true 
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