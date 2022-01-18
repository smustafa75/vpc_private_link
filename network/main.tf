data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "VPC - Module Example"
  }
}

resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id = aws_vpc.tf_vpc.id
    service_name = "com.amazonaws.us-east-1.s3"
}

resource "aws_vpc_endpoint_route_table_association" "route_table_association" {
    route_table_id = aws_default_route_table.tf_private_rt.id
    vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}
