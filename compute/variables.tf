variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = 1
}


variable "private_security_group" {

default =""  
}

variable "public_security_group" {
  default =""
}

variable "instance_profile" {
  
}

variable "private_net" {
type    = list(string)
  default = []
   }

variable "public_net" {
type    = list(string)
  default = []
   }

