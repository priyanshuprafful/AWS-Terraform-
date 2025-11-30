variable "environment" {

  default = "dev"
  type = string
  
}

variable "region" {
  default = "us-east-1"
  type = string
  
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  
}

