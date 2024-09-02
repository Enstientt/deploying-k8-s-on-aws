output "instance_ips" {
  description = "The public IPs of the EC2 instances"
  value       = aws_instance.app[*].public_ip
}

output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.app[*].id
}