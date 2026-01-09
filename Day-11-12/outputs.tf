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

output "all_locations" {
    value =  toset(concat(var.default_locations, var.user_locations))
}

output  "positive_cost" {
   #value = [ for cost in var.monthly_cost : abs(cost) ]
    value = local.positive_cost # this is a tuple
}   

# output "max_cost" {
#     value = max(local.positive_cost)
# }                                      # all these didn't work because these function works on list and not on tuple

# output "min_cost" {
#     value = min(local.positive_cost)
# } 

# output "total_cost" {
#     value = sum(local.positive_cost)
# } 

output "max_cost" {
    value = max(local.positive_cost...)  #... is used to convert tuple to list
} 