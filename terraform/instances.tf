resource "aws_instance" "webserver" {
  ami = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_rules.id]
  private_ip = "10.0.100.100"
  subnet_id = aws_subnet.ws_subnet.id
  key_name = "webkey"

  tags = {
    Name = "WebServer"
  }
}

resource "aws_eip" "ws_ip" {
  vpc = true
  instance = aws_instance.webserver.id
  associate_with_private_ip = "10.0.100.100"
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_security_group" "web_rules" {
  name = "security group for web servers"
  vpc_id = aws_vpc.vpc_for_web.id

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
#    cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["94.45.94.33/32", "94.45.90.83/32", "18.198.15.238/32"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks =  ["0.0.0.0/0"]
  }
}

output "instance_ips" {
  value = aws_eip.ws_ip.*.public_ip
}