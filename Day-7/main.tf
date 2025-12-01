# create an ec2 instance
resource "aws_instance" "example" {
  
  count = var.instance_count
  ami           = "ami-026012a857b852da3" # RHEL 9 AMI in us-east-1
  instance_type = var.instance_types[0]
  region = tolist(var.allowed_region)[0]
  monitoring = var.monitoring_enabled
  associate_public_ip_address = var.associate_public_ip


  tags = var.tags
  # tags = {
  #   environment = var.environment
  #   Name = "${var.environment}-EC2-instance"
  # }
}



resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_security_group"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_tls"
  }
}
 # Ingress rule to allow TLS traffic from within the VPC (both IPv4 and IPv6)
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_ipv4[0] 
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }