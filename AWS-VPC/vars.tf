#VPC

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpc_instance_tenancy" {
  description = "The tenancy of instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "vpc_enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "vpc_assign_generated_ipv6_cidr_block" {
  description = "Should be false to disable automatically assigning an IPv6 CIDR block"
  type        = bool
  default     = false
}

variable "vpc_tags" {
  description = "A map of tags to assign to the VPC"
  type        = map(string)
  default     = {
    Name = "main"
  }
}

#IGW

variable "internet_gateway_tags" {
  description = "A map of tags to assign to the Internet Gateway"
  type        = map(string)
  default     = {
    Name = "main"
  }
}

#SUBNET

variable "subnet_cidr_public_1" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "192.168.0.0/18"
}

variable "subnet_cidr_public_2" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "192.168.64.0/18"
}

variable "subnet_cidr_private_1" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "192.168.128.0/18"
}

variable "subnet_cidr_private_2" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "192.168.192.0/18"
}

variable "subnet_availability_zone_public_1" {
  description = "Availability zone for public subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_availability_zone_public_2" {
  description = "Availability zone for public subnet 2"
  type        = string
  default     = "us-east-1b"
}

variable "subnet_availability_zone_private_1" {
  description = "Availability zone for private subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_availability_zone_private_2" {
  description = "Availability zone for private subnet 2"
  type        = string
  default     = "us-east-1b"
}

variable "subnet_map_public_ip_on_launch" {
  description = "Whether instances in the subnet should have public IP addresses on launch"
  type        = bool
  default     = true
}

variable "subnet_pub_tags" {
  description = "Common tags to apply to all subnets"
  type        = map(string)
  default     = {
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

variable "subnet_pri_tags" {
  description = "Common tags to apply to all subnets"
  type        = map(string)
  default     = {
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

#NAT GW

variable "nat_gateway_tags_1" {
  description = "A map of tags to assign to the first NAT Gateway"
  type        = map(string)
  default     = {
    "Name" = "NatGateway1"
  }
}

variable "nat_gateway_tags_2" {
  description = "A map of tags to assign to the second NAT Gateway"
  type        = map(string)
  default     = {
    "Name" = "NatGateway2"
  }
}

variable "public_route_cidr" {
  description = "CIDR block for the public route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_route_cidr" {
  description = "CIDR block for the private routes"
  type        = string
  default     = "0.0.0.0/0"
}
