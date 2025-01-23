
output "security_group_id" {
  value       = aws_security_group.nginx_sg.id
  description = "Security Group ID for the EC2 instance"
}