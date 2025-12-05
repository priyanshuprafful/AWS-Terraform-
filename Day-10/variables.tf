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
    Compliance  = "yes"
  }
  
}

variable "ingress_values" {

  type = tuple([ number, string, number ])
  default = [443, "tcp", 443]
  
}

variable "config" {
  description = "A map of configuration values"
  type        = object({
    region = string,
    monitoring = bool,
    instance_count = number

  })
  default     = {
    region         = "us-east-1",
    monitoring     = true,
    instance_count = 1
  }
  
}

variable "bucket_names" {
  description = "List of S3 bucket names"
  type        = list(string)
  default     = ["my-unique-bucket-prafful-123456", "my-unique-bucket-prafful-654321"]
  
}
# Ingress_rule = [object1, object2, object3]
# basically this is map type 
variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port = 80
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    },
    {
      from_port   = 443
      to_port = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    }
  ]
}