resource "aws_internet_gateway" "tf_internet_gw" {
  vpc_id = aws_vpc.tf_vpc.id 

  tags = {
    Name = "IGW - Module Example"
  }
}

#resource "aws_eip" "tf_nat_gw_eip" {
#  depends_on = [
#    aws_route_table_association.tf_public_assoc
#  ]
#  vpc = true
#  tags = {
#    Name = "EIP - Module Example"
#  }
#}

#resource "aws_nat_gateway" "nat_gw" {
#  depends_on = [
#    aws_eip.tf_nat_gw_eip
#  ]
#  allocation_id = aws_eip.tf_nat_gw_eip.id
#  #subnet_id = element(aws_vpc.tf_vpc.tf_public_subnet[count.index])
#  subnet_id = aws_subnet.tf_public_subnet.*.id[0]
#  tags = {
#    Name = "NATGW - Module Example"
#  }
#}


resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_internet_gw.id 

  }

  tags = {
    Name = "Public RT - Module Example"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]


  tags = {
    Name = "tf_public_${count.index + 1}"
  }
}

resource "aws_route_table_association" "tf_public_assoc" {
  count          = length(aws_subnet.tf_public_subnet)
  subnet_id      = aws_subnet.tf_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.tf_public_rt.id
}


resource "aws_security_group" "tf_public_sg" {
  name        = "tf_public_sg"
  description = "Access instances in public subnet"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ var.accessip, "0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
