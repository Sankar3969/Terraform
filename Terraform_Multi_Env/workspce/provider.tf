terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.69.0"
    }
  }
  backend "s3" {
    bucket         = "aws-expense-wrkpsc"
    key            = "terraform-expense-wrkpsc"
    region         = "us-east-1"
    dynamodb_table = "expense-dev-wrkpsc"
    }
}

provider "aws" {
  # Authentication has to provide here 
  region = "us-east-1"
}