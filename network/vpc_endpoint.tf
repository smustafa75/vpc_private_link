#resource "vpc_endpoint" "s3_storage" {
#    vpc_id = aws_vpc.tf_vpc.id
#    service_name = "com.amazonaws.us-east-1.s3"
#}

#resource "aws_vpc_endpoint_route_table_association" "route_table_association" {
#    route_table_id = aws_default_route_table.tf_private_rt.id
#    vpc_endpoint_id = aws_vpc_endpoint.s3_storage.id
#}
