output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "Public IP address (for SSH access)"
  value       = aws_instance.app.public_ip
}

output "private_ip" {
  description = "Private IP address"
  value       = aws_instance.app.private_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.app_sg.id
}