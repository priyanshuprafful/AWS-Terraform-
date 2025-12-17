locals {
    formatted_project_name = lower(var.project_name)
    formatted_bucket_name = replace(substr(lower(var.bucket_name), 0, 63)," ", "")
}

# create s3 bucket
resource "aws_s3_bucket" "project_bucket_day11" {
    bucket = local.formatted_bucket_name
    
    tags = merge(var.default_tags, var.environment_tags)
    
}  