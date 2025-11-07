output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "nat_id" {
  value = module.nat.nat_id
}

output "public_ec2_id" {
  value = module.ec2.public_instance_id
}

output "private_ec2_id" {
  value = module.ec2.private_instance_id
}

output "public_ec2_ip" {
  value = module.ec2.public_instance_public_ip
}

