variable "aws_region" {
  type = string
  description = ""
  default = "us-east-2" #Ohio
}

variable "aws_profile" {
  type = string
  description = ""
  default = "default"
}

variable "instance_ami" {
  type = string
  description = ""
  default = "ami-00399ec92321828f5" #ubuntu 20.04
  #default = "ami-0d8d212151031f51c" #Amazon Linux 2
}

variable "instance_type" {
  type = string
  description = ""
  default = "t2.micro"
}

variable "instance_tags" {
  type = map(string)
  description = ""
  default = {
    Name = "Ubuntu"
    Project = "Curso AWS Terraform"
  }
}

