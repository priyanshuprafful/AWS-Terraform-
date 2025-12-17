locals {
    formatted_project_name = lower(var.project_name)
}

# create s3 bucket
resource "aws_s3_bucket" "project_bucket_day11" {
    bucket = replace(local.formatted_project_name, " ", "-")
    
    tags = merge(var.default_tags, var.environment_tags)
    
}  