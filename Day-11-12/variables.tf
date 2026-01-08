variable "project_name" {
  description = "The name of the project."
  type        = string
  default = "Project ALPHA Resource"
}

variable "default_tags" {
  default = {
    company       = "DevOps Team"
    managed_by = "Prafful"
  }
  
}

variable "environment_tags" {
  default = {
    environment = "Development"
    cost_center = "CC1001"
  }
}

variable "bucket_name" {
  default = "ProjectAlphaStorageBucket with CAPS and spaces tu hai prafful !!!"
}

variable "allowed_ports" {

  default = "80,443,8080,3306"
  
}

variable "instance_sizes" {
  default =  {
    dev = "t3.micro"
    prod = "t3.medium"
    staging = "t3.small"
  }
  
}

variable "environment" {
  default = "dev"
  
}

variable "instance_type" {
  default = "t2.micro"

  validation {
    condition = length(var.instance_type) >= 2 && length(var.instance_type) <= 30
    error_message = "Instance type must be between 2 and 20 characters long."
  }

  validation {
    condition = can(regex("^t[2-3]\\.",var.instance_type))
    error_message = "Instance type must be a valid t2 or t3 instance type."
  }
  
}

variable "backup_name" {
  default = "ProjectAlphaBackup"

  validation {
    condition = endswith(var.backup_name, "Backup")
    error_message = "Backup name must end with 'Backup'."
  }
}