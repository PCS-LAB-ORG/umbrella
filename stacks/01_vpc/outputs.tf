output "vpc_1" {
  description = "The ID of the vpc_1"
  value       = module.vpc_1.vpc_id
}

output "public_subnets_1" {
  description = "The ID of the public_subnet_a"
  value       = module.vpc_1.public_subnets[0]
}

output "public_subnets_2" {
  description = "The ID of the public_subnet_b"
  value       = module.vpc_1.public_subnets[1]
}