locals {
    formatted_project_name = lower(var.project_name)
}

output "formatted_project_name" {
    value = local.formatted_project_name
  
}