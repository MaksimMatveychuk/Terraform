terraform {
  backend "s3" {
    bucket  = "techtask-deploy-only-bucket"
    encrypt = true
    key     = "AWS/techtask-deploy-only-bucket-terraform-states/terraform.tfstate"
    region  = "eu-north-1"
  }
}

provider "aws" {}

resource "aws_default_vpc" "default_techtask_vpc" {}


