
output "private_net" {
  value = aws_subnet.tf_private_subnet.*.id
}

output "public_net" {
  value = aws_subnet.tf_public_subnet.*.id
}

output "vpcname" {
  value = aws_vpc.tf_vpc.id
}

output "p_subnet_id"{
  value = aws_subnet.tf_private_subnet.*.id
}
output "private_security_group" {
  value = aws_security_group.tf_private_sg.id
}


output "private_subnets_cidr" {
  value = aws_subnet.tf_private_subnet.*.cidr_block
}

output "public_subnets_cidr" {
  value = aws_subnet.tf_public_subnet.*.cidr_block
  
}

output "public_security_group" {
  value = aws_security_group.tf_public_sg.id
}

output "vpc_endpoint" {
  value = aws_vpc_endpoint.s3_endpoint.id
}