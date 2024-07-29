terraform {
  backend "s3" {
    bucket  = "test-bucket-02-new"
    encrypt = true
    key     = "AWS/Terraform-states/terraform.tfstate"
    region  = "eu-north-1"
  }
}

provider "aws" {}

resource "aws_default_vpc" "default_vpc" {}

