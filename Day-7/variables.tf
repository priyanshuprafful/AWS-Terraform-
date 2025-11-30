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

variable "monitoring_enabled" {

  description = "Enable detailed monitoring"
  type        = bool
  default     = true
  
}

variable "associate_public_ip" {

  description = "Associate a public IP address with the instance"
  type        = bool
  default     = true
  
}