data "aws_region" "current_region" {}

data "aws_caller_identity" "current_user" {}

data "aws_availability_zones" "availability_zones" {}

data "aws_security_group" "vpc_techtask_security_group" {
  name = "Security_group_for_Techtask_project"
}

data "aws_key_pair" "keypair" {
  key_name = "terraform_ec2_key_pair"
}

data "aws_iam_instance_profile" "aws_iam_instance_profile_tt" {
  name = "new-ecs-instance-profile-tt"
}


data "aws_subnets" "example" {
  filter {
    name = "vpc-id"
    values = ["vpc-08ddf05f59956b856"]
  }

  filter {
    name = "tag:Name"
    values = [
      "Default subnet for eu-north-1b", "Default subnet for eu-north-1a",
      "Default subnet for eu-north-1c"
    ]
  }

}

data "aws_iam_role" "ecs_task_execution_role_arn" {
  name = "ecs-ex-role"
}
data "aws_iam_role" "ecs_instance_role" {
  name = "ecs-inst-role"
}

data "aws_ami" "aws_linux_latest_ecs" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-ecs-kernel-5.10-hvm-2.0.20240712-x86_64-ebs"]
  }
}

output "ami_id" {
  value = data.aws_ami.aws_linux_latest_ecs.image_id
}
data "aws_instances" "filtered_instances" {
  filter {
    name   = "tag:Name"
    values = ["Ecs-Back-Instance-ASG"]
  }
}

data "aws_instance" "filtered_instance_details" {
  for_each = toset(data.aws_instances.filtered_instances.ids)
  instance_id = each.value
}

output "ecs_instance_public_ips" {
  description = "Public IP addresses of the filtered instances"
  value       = [for instance in data.aws_instance.filtered_instance_details : instance.public_ip]
}