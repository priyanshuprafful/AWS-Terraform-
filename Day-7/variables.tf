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

variable "cidr_ipv4" {
  description = "CIDR block for IPv4 ingress rule"
  type        = list(string)
  default     = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]

  
}


variable "instance_types" {
  description = "Type of EC2 instances to create"
  type        = list(string)
  default     = ["t2.micro", "t3.micro", "t3a.micro" , "t4g.micro"]
  
}


variable "allowed_region" {
  description = "Allowed AWS region"
  type        = list(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1"]
  
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Name        = "Terraform-EC2-instance"
    Owner       = "priyanshuprafful"
    Project     = "TerraformSeries"
    Environment = "dev"
  }
  
}