terraform {
  required_version = "0.15.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_instance" "servidorterraform" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  security_groups = var.security_groups
  tags = var.instance_tags
  
}