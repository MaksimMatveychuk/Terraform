terraform {
  backend "s3" {
    bucket = "aws_terraform_states_backend"
    key    = "backTestDeploy/terraform.tfstate"
    region = "eu-north-1"
  }
}

resource "aws_s3_bucket" "backend_s3_bucket" {
  bucket = "aws_terraform_states_backend"

  tags = {
    Name = "aws_terraform_states_backend"
  }
}