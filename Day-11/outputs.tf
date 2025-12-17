output "formatted_project_name" {
    value = local.formatted_project_name
  
}

output "formatted_project_name_repo" {
    value = upper(replace(local.formatted_project_name, "_", "-"))
}  