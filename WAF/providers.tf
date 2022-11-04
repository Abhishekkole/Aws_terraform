terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.35.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}
