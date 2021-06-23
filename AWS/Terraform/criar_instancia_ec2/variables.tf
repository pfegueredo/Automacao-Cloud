variable "aws_region" {

  type = string

  description = ""

  default = "us-east-2"
}

variable "aws_profile" {

  type = string

  description = ""
  
  default = "terraform"
}

variable "instance_ami" {

  type = string

  description = ""
  
  default = "ami-077e31c4939f6a2f3"
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