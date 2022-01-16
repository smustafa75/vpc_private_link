
output "private_cidrs" {
  value = aws_subnet.tf_private_subnet.*.cidr_block
}

output "vpcname" {
  value = aws_vpc.tf_vpc.id
}


output "private_security_group" {
  value = aws_security_group.tf_private_sg.id
}
