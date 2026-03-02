# Security Group for SSH access
resource "aws_security_group" "app_sg" {
  name   = "${var.instance_name}-sg"
  vpc_id = var.vpc_id

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "app_profile" {
  name = "${var.instance_name}-profile"
  role = var.iam_role_name
}

# EC2 Instance
resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  iam_instance_profile   = aws_iam_instance_profile.app_profile.name
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = var.instance_name
  }
}