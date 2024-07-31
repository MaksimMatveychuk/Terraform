terraform {
  backend "s3" {
    bucket  = "create-infrastructure-only-bucket"
    encrypt = true
    key     = "AWS/create-infrastructure-only-bucket-terraform-states/terraform.tfstate"
    region  = "eu-north-1"
  }
}

provider "aws" {}

resource "aws_default_vpc" "default_techtask_vpc" {}

resource "aws_ecs_cluster" "techtask_back_cluster" {
  name = "techtask-cluster"
}

