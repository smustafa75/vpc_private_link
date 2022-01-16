output "VPC_Name" {
  description = "VPC Name"
  value       = module.network.vpcname
}


output "Private_Subnets" {
  description = "Private Subnets"
  value       = module.network.private_cidrs
}

output "Bucket_Name" {
  value = module.storage.bucketname
}

#output "servers" {
#  value = module.compute.server_id
#}

#output "public_ip" {
#  value = module.compute.server_ip
#}
output "role_name" {
  value = module.iam.iam_role
}



