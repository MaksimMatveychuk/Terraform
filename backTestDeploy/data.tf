data "aws_availability_zones" "available_zones" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ami" "aws_linux_latest_ecs" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-kernel-5.10-hvm-2.0.20240712-x86_64-ebs"]
  }
}
output "ami_id" {
  value = data.aws_ami.aws_linux_latest_ecs.image_id
}