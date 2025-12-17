locals {
    formatted_project_name = lower(var.project_name)
    formatted_bucket_name = replace(replace(substr(lower(var.bucket_name), 0, 63)," ", ""), "!", "")
    port_list = split(",", var.allowed_ports)

    sg_rules = [
        for port in local.port_list : {
            name = "port is - ${port}" # to number bhi use kar sakte hai ya karna chaiye saath mein
            port = port
            description = "Allow inbound traffic on port ${port}"
        }
    ]
}

# create s3 bucket
resource "aws_s3_bucket" "project_bucket_day11" {
    bucket = local.formatted_bucket_name
    
    tags = merge(var.default_tags, var.environment_tags)
    
}  