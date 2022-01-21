output "VPC_Name" {
  description = "VPC Name"
  value       = module.network.vpcname
}


output "Private_Subnets" {
  description = "Private Subnets"
  value       = concat(module.network.private_net, module.network.private_subnets_cidr)
}

output "Public_Subnets" {
  description = "Public Subnets"
  value       = concat(module.network.public_net, module.network.public_subnets_cidr)
}
output "Bucket_ID" {
  value = module.storage.bucketname
}
output "Bucket_ARNs" {
  value = module.storage.bucket_arn
}

output "Bucket_ARN" {
  value = module.storage.bucket_arn
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
output "vpc_end_point" {
  value = module.network.vpc_endpoint

}


