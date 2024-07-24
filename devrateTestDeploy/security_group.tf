resource "aws_security_group" "DevrateSG" {
  name        = "Test-SG-for-Devrate"
  description = "Allow tcp inbound traffic and all outbound traffic"

  dynamic "ingress" {
    for_each = ["22", "80", "3000", "8080"]
    content {
      protocol  = "tcp"
      from_port = ingress.value
      to_port   = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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


resource "aws_elb" "back_load_balancer" {
  name = "back-lb"
  availability_zones = [
    data.aws_availability_zones.available_zones.names[0],
    data.aws_availability_zones.available_zones.names[1],
    data.aws_availability_zones.available_zones.names[2]
  ]
  security_groups = [aws_security_group.DevrateSG.id]
  listener {
    lb_port           = 8080
    lb_protocol       = "http"
    instance_port     = 8080
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "HTTP:8080/"
    timeout             = 8
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Back-ELB"
  }
}
