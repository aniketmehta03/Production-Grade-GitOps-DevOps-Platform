variable "aws_region" {
  description = "aws region"
  default     = "ap-south-1"
}

variable "name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "node-api-Cluster-V1"
}

variable "vpc_cidr" {
  description = "vpc cidr"
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "availability zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnets" {
  description = "public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "intra_subnets" {
  description = "intra subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default = {
    Project = "EKS-Cluster"
    Owner   = "DevOps-Team"
  }
}