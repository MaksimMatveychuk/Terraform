variable "untagged_images" {
  default = 2
}

variable "region" {
  default = "eu-north-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "back_rep_name" {
  default = "backrepository"
}

variable "list_of_ports" {
  default = ["22", "80", "3000", "8080"]
}

variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "port" {
  default = 8080
}
