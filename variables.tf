variable "aws_region" {
  default = "eu-west-1"
}

variable "project_name" {
  default = "VPC Private Link for S3"
}

variable "vpc_cidr" {

}


variable "private_cidrs" {

}


variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = 1
}

variable "policy_name" {
  default = ""
}

variable "role_name" {
  default = ""
}

variable "s3_policy" {
  default = ""
}

variable "instance_profile" {
  default = ""
}
