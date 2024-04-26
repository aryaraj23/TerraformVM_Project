terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "5.46.0"
      }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}


resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_1a" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet_1a"
  }
}

resource "aws_subnet" "subnet_1b" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnet_1b"
  }
}

resource "aws_subnet" "subnet_1c" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1c"


  tags = {
    Name = "subnet_1c"
  }
}


resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "mygw"
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }

  tags = {
    Name = "rt_public"
  }
}



resource "aws_route_table_association" "associate-1a-rt" {
  subnet_id      = aws_subnet.subnet_1a.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table_association" "associate-1b-rt" {
  subnet_id      = aws_subnet.subnet_1b.id
  route_table_id = aws_route_table.rt_public.id
}


resource "aws_instance" "web001" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1a.id
  vpc_security_group_ids = [ aws_security_group.webservers.id ]
  key_name = "Arya"
  tags = {
    Name = "Web001"
  }
   user_data = <<-EOF
    ${file("fronend.sh")}
    chmod +x /tmp/fronend.sh
    /tmp/fronend.sh
  EOF
}

resource "aws_instance" "web002" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1a.id
  vpc_security_group_ids = [ aws_security_group.webservers.id ]
  key_name = "Arya"
  tags = {
    Name = "Web002"
  }
  user_data = <<-EOF
    ${file("fronend.sh")}
    chmod +x /tmp/fronend.sh
    /tmp/fronend.sh
  EOF
}

resource "aws_instance" "web003" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1a.id
  vpc_security_group_ids = [ aws_security_group.webservers.id ]
  key_name = "Arya"
  tags = {
    Name = "Web003"
  }
  user_data = <<-EOF
    ${file("fronend.sh")}
    chmod +x /tmp/fronend.sh
    /tmp/fronend.sh
  EOF
}

resource "aws_instance" "web004" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1b.id
  vpc_security_group_ids = [ aws_security_group.webservers.id ]
  key_name = "Arya"
  tags = {
    Name = "Web004"
  }
  user_data = <<-EOF
    ${file("backend1.sh")}
    chmod +x /tmp/backend1.sh
    /tmp/backend1.sh
  EOF

}

resource "aws_instance" "web005" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1b.id
  vpc_security_group_ids = [ aws_security_group.webservers.id ]
  key_name = "Arya"
 tags = {
    Name = "Web005"
  }
   user_data = <<-EOF
    ${file("backend1.sh")}
    chmod +x /tmp/backend1.sh
    /tmp/backend1.sh
  EOF

}

resource "aws_instance" "web006" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1b.id
  vpc_security_group_ids = [ aws_security_group.webservers.id ]
  key_name = "Arya"
  tags = {
    Name = "Web006"
  }
   user_data = <<-EOF
    ${file("backend1.sh")}
    chmod +x /tmp/backend1.sh
    /tmp/backend1.sh
  EOF

}

resource "aws_instance" "web007" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1c.id
  vpc_security_group_ids = [ aws_security_group.webserverPython.id ]
  key_name = "Arya"
  tags = {
    Name = "Web007"
  }
   user_data = <<-EOF
    ${file("backend2.sh")}
    chmod +x /tmp/backend2.sh
    /tmp/backend2.sh
  EOF

}

resource "aws_instance" "web008" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1c.id
  vpc_security_group_ids = [ aws_security_group.webserverPython.id ]
  key_name = "Arya"
  tags = {
    Name = "Web008"
  }
   user_data = <<-EOF
    ${file("backend2.sh")}
    chmod +x /tmp/backend2.sh
    /tmp/backend2.sh
  EOF

}

resource "aws_instance" "web009" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1c.id
  vpc_security_group_ids = [ aws_security_group.webserverPython.id ]
  key_name = "Arya"
  tags = {
    Name = "Web009"
  }
   user_data = <<-EOF
    ${file("backend2.sh")}
    chmod +x /tmp/backend2.sh
    /tmp/backend2.sh
  EOF

}

resource "aws_security_group" "webservers" {
  name        = "webservers-80"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "webserverPython" {
  name       = "webserverPython"
  vpc_id     = aws_vpc.myvpc.id

  ingress {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["10.0.0.0/16"]
 }

 egress  {
   from_port     = 0
   to_port       = 0
   protocol      = "-1"
   cidr_blocks   = ["10.0.0.0/16"]
  }

}

resource "aws_security_group" "lb_webservers" {
  name        = "lb-webservers-80"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}

resource "aws_lb_target_group" "mywebservergroup" {
  name     = "webservergroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_target_group_attachment" "attach_web001_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup.arn
  target_id        = aws_instance.web001.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_web004_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup.arn
  target_id        = aws_instance.web004.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_web007_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup.arn
  target_id        = aws_instance.web007.id
  port             = 80
}


resource "aws_lb_target_group" "mywebservergroup2" {
  name     = "webservergroup2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_target_group_attachment" "attach_web002_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup2.arn
  target_id        = aws_instance.web002.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_web005_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup2.arn
  target_id        = aws_instance.web005.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_web008_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup2.arn
  target_id        = aws_instance.web008.id
  port             = 80
}

resource "aws_lb_target_group" "mywebservergroup3" {
  name     = "webservergroup3"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_target_group_attachment" "attach_web003_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup3.arn
  target_id        = aws_instance.web003.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_web006_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup3.arn
  target_id        = aws_instance.web006.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_web009_tg" {
  target_group_arn = aws_lb_target_group.mywebservergroup3.arn
  target_id        = aws_instance.web009.id
  port             = 80
}

resource "aws_lb" "lb-webservers" {
  name               = "lb-webservers"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_webservers.id]
  subnets            = [ aws_subnet.subnet_1a.id, aws_subnet.subnet_1b.id, aws_subnet.subnet_1c.id  ]
  tags = {
    Environment = "preview"
  }
}

resource "aws_lb_listener" "front_end_80" {
  load_balancer_arn = aws_lb.lb-webservers.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mywebservergroup.arn
  }
}

resource "aws_lb_listener" "java_80" {
  load_balancer_arn = aws_lb.lb-webservers.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mywebservergroup2.arn
  }
}

resource "aws_lb_listener" "python_80" {
  load_balancer_arn = aws_lb.lb-webservers.arn
  port              = "8081"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mywebservergroup3.arn
  }
}
