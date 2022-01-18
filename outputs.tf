output "VPC_Name" {
  description = "VPC Name"
  value       = module.network.vpcname
}


output "Private_Subnets" {
  description = "Private Subnets"
  value       = concat(module.network.private_subnets, module.network.public_subnets_cidr)
}

output "Public_Subnets" {
  description = "Public Subnets"
  value       = concat(module.network.public_subnets, module.network.public_subnets_cidr)
}
output "Bucket_Name" {
  value = module.storage.bucketname
}

output "servers" {
  value = module.compute.server_id
}

output "public_ip" {
  value = module.compute.server_ip
}
output "role_name" {
  value = module.iam.iam_role
}



