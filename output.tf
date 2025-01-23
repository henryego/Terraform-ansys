output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "ami_id" {
  value       = data.aws_ami.myami.id
  description = "The ID of the ami"
}