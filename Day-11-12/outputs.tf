output "formatted_project_name" {
    value = local.formatted_project_name
  
}

output "formatted_project_name_repo" {
    value = upper(replace(local.formatted_project_name, " ", "-"))
}  

output "s3_bucket_name" {
    value = var.bucket_name
  
}


output "port_list" {

    value = local.port_list
  
}

output "security_group_rules" {
    value = local.sg_rules
}

output "port_number_list" {
    value = local.port_number_list
  
}

output "instance_size_for_environment" {
    value = local.instance_size
}

output "credentials" {
    value = var.credentials
    sensitive = true
}