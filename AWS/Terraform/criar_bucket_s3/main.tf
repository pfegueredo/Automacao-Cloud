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
  region  = "us-east-2"
  profile = "terraform"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "paulofegueredo2021"
  acl    = "private"

  tags = {
    Name        = "Meu primeiro bucket via Terraform"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Paulo Fegueredo"
    UpdateAt    = "2021-05-30"
  }
}