
# need terraform.tfvars to inject values
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID (e.g., Ubuntu 20.04: ami-xxxxxxxxx)"
  type        = string
}

variable "instance_type" {
  description = "Instance type (e.g., t2.micro, t2.small)"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where instance will be launched"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security group"
  type        = string
}

variable "iam_role_name" {
  description = "IAM role name to attach"
  type        = string
}

variable "key_pair_name" {
  description = "SSH key pair name (must exist in AWS)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "create_security_group" {
  description = "Whether to create a security group for SSH access"
  type        = bool
  default     = true
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}