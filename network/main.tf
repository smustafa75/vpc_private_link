data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "VPC - Module Example"
  }
}

resource "aws_internet_gateway" "tf_internet_gw" {
  vpc_id = aws_vpc.tf_vpc.id 

  tags = {
    Name = "IGW - Module Example"
  }
}

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
resource "aws_default_route_table" "tf_private_rt" {
  
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id

  tags = {
    Name = "Private RT - Module Example"
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


resource "aws_subnet" "tf_private_subnet" {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]


  tags = {
    Name = "tf_private_${count.index + 1}"
  }
}

resource "aws_route_table_association" "tf_public_assoc" {
  count          = length(aws_subnet.tf_public_subnet)
  subnet_id      = aws_subnet.tf_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "tf_private_assoc" {
  count          = length(aws_subnet.tf_private_subnet)
  subnet_id      = aws_subnet.tf_private_subnet.*.id[count.index]
  route_table_id = aws_default_route_table.tf_private_rt.id
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

resource "aws_security_group" "tf_private_sg" {
  name        = "tf_private_sg"
  description = "Access instances in private subnet"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}