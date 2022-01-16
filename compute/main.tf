data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}


resource "aws_instance" "tf_server" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  vpc_security_group_ids = [var.private_security_group]
  subnet_id              = element(var.private_cidrs,count.index)
  iam_instance_profile = var.instance_profile

  tags = {
    Name = " EC2 - TF_Server-${count.index + 1 }"
  }
}
