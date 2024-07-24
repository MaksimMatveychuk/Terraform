variable "untagged_images" {
  default = 2
}

variable "subnet_ids" {
  description = "List of existing subnet IDs"
  type = list(string)
  default = [
    "subnet-022d0b0b12b180e6c", "subnet-0dd339acdd27a9211", "subnet-01fa40df199cd1afc",
    "subnet-07ec2fbc65bcd3fe0", "subnet-070bc9c306e831652", "subnet-0e60dbf89d3c3336f"
  ]
}