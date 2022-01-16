variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = 1
}


variable "private_security_group" {
  
}

variable "instance_profile" {
  
}

variable "private_cidrs" {
   type    = list(string)
  default = []
}