variable "max_untagged_images" {
  description = "The maximum number of untagged images to retain in the repository."
  default     = 2
}

variable "region" {
  description = "AWS region to host your infrastructure"
  default     = "eu-north-1"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t3.micro"
}

variable "back_repository_name" {
  description = "Repository name"
  default     = "techtask-backend"
}


variable "back_cluster_name" {
  description = "Back cluster name"
  default     = "techtask-cluster"
}

variable "list_of_ports" {
  description = "The list of ports the app will use for each other"
  default     = ["22", "80", "3000", "8080"]
}

variable "cidr_blocks" {
  description = "The list of cidrs to use for each other"
  default     = ["0.0.0.0/0"]
}

variable "back_port" {
  description = "Port number on which back service is listening"
  default     = 8080
}

variable "work_directory" {
  description = "Work build directory for building docker image"
  default     = "/home/runner/work/Terraform/Terraform/backend"
}

variable "image_tag" {
  default = "latest"
}
