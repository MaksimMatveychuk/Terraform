resource "aws_security_group" "DevrateSG" {
  name        = "Test-SG-for-Devrate"
  description = "Allow tcp inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default_vpc.id
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

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.available_zones.names[0]}"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]

  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.available_zones.names[1]}"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = data.aws_availability_zones.available_zones.names[2]

  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.available_zones.names[2]}"
  }
}


# resource "aws_elb" "back_load_balancer" {
#   name = "back-lb"
#   availability_zones = [
#     data.aws_availability_zones.available_zones.names[0],
#     data.aws_availability_zones.available_zones.names[1],
#     data.aws_availability_zones.available_zones.names[2]
#   ]
#   security_groups = [aws_security_group.DevrateSG.id]
#   listener {
#     lb_port           = var.port
#     lb_protocol       = "http"
#     instance_port     = var.port
#     instance_protocol = "http"
#   }
#   health_check {
#     healthy_threshold   = 2
#     interval            = 10
#     target              = "HTTP:${var.port}/"
#     timeout             = 8
#     unhealthy_threshold = 2
#   }
#
#   tags = {
#     Name = "Back-ELB"
#   }
# }
