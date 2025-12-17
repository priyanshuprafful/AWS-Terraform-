output "formatted_project_name" {
    value = local.formatted_project_name
  
}

output "formatted_project_name_repo" {
    value = upper(replace(local.formatted_project_name, " ", "-"))
}  

output "s3_bucket_name" {
    value = aws_s3_bucket.project_bucket_day11.bucket
  
}