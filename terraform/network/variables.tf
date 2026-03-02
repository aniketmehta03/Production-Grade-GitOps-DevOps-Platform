variable "region" {
   description = "aws-region"
    type        = string
    default     = "ap-south-1"
}

variable "cidr_block" {
  description = "CIDR for VPC"
  default = "10.0.0.0/16"
}

variable "subnet_count" {
    description = "Number of public subnets to create"
    default     = 1
    type        = number
}

variable "public_subnet_cidr" {
   description = "cidr for public subnet"
   default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
   description = "cidr for private subnet"
   default = "10.0.2.0/24"
}

variable "subnet_name_prefix" {
  description = "Prefix for subnet names"
  default     = "terraform"
}

variable "gateway_name" {
  description = "igw name"
  default = "my_igw"
}

variable "nat_gateway_name" {
  description = "NAT Gateway Name"
  default     = "my_nat_gw"
}

variable "rt_public_cidr" {
    description = "CIDR block for public route table"
    default     = "0.0.0.0/0"
}

variable "rt_private_cidr" {
   description = "CIDR block for private route table"
   default     = "0.0.0.0/0"
}