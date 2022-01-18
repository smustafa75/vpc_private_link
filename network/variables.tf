variable "vpc_cidr" {

}

variable "private_subnets" {

  type    = list(string)
  default = []
}

variable "public_subnets" {

  type    = list(string)
  default = []
}

variable "accessip" {
  default = "0.0.0.0/0"
}
