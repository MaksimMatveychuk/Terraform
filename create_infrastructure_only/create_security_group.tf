resource "aws_security_group" "techtask_security_group" {
  name        = "Security_group_for_Techtask_project"
  description = "Allow tcp inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default_techtask_vpc.id

  dynamic "ingress" {
    for_each = var.list_of_ports
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = var.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
}

resource "aws_default_subnet" "default_techtask_az1" {
  availability_zone = data.aws_availability_zones.availability_zones.names[0]

  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.availability_zones.names[0]}"
  }
}

resource "aws_default_subnet" "default_techtask_az2" {
  availability_zone = data.aws_availability_zones.availability_zones.names[1]

  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.availability_zones.names[1]}"
  }
}

resource "aws_default_subnet" "default_techtask_az3" {
  availability_zone = data.aws_availability_zones.availability_zones.names[2]

  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.availability_zones.names[2]}"
  }
}
