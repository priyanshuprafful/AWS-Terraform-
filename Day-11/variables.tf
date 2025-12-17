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