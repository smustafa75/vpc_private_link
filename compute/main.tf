data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

data "template_file" "user-init" {
  count    = 2
  template = file("${path.module}/userdata.tpl")

  vars = {
    firewall_subnets = "${element(var.public_net, count.index)}"
  }
}
data "template_file" "p_user-init" {
  count    = 2
  template = file("${path.module}/p_userdata.tpl")

  vars = {
    firewall_subnets = "${element(var.private_net, count.index)}"
  }
}

resource "aws_instance" "tf_server" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name = "RepoKey"
  vpc_security_group_ids = [var.private_security_group]
  subnet_id              = element(var.private_net,count.index)
  iam_instance_profile = var.instance_profile

  tags = {
    Name = " EC2 - Private_TF_Server-${count.index + 1 }"
  }
}

resource "aws_instance" "public_tf_server" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name = "RepoKey"
  vpc_security_group_ids = [var.public_security_group]
  subnet_id              = element(var.public_net,count.index)
  user_data              = "${data.template_file.user-init.*.rendered[count.index]}"
  iam_instance_profile = var.instance_profile

  tags = {
    Name = " EC2 - Public_TF_Server-${count.index + 1 }"
  }
}