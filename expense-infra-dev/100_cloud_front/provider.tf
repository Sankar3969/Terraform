terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.69.0"
    }
  }
  backend "s3" {
    bucket         = "aws-expense-dev"
    key            = "terraform-expense-cdn"
    region         = "us-east-1"
    dynamodb_table = "expense-dev-tab"
  }
}

provider "aws" {
  # Authentication has to provide here 
  region = "us-east-1"
}