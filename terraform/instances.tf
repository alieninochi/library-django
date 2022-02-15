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

#resource "aws_key_pair" "webkey" {
#  key_name = "webkey"
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNkHuvf1+Z5GLJUN0UVNr/guhO/P8eeT/frdhB6npZYAG1tCHTQTZl+4R+viSMhos5DMr3rua6Y9dUn3BcxFUFMG0Be7/f6I10tEc4Eff2guv2Dpkm4y4+Xg1gkcAIdExrxjmcHmtxusM3TmBdRCftYnUsbowJxCRp1dGn2js6P7oJHRvbuVqYVsuJgU+UUfjcOT/gnPj8+i+iK73u69fAG9jr6biTCng7gR38udHkP1aXm+w5LE64nlpur9hfAIrOSePKVbkRHKl0bcjbRRkAb8D3I07XOPSaEZBv0T+dyO2wh6xPkYFu6W5Yi7kzSIFdalcsagYvRakVi5wzg+naT19lRDfOd1Qjlm5jPNgdmQ2iaK+pf9E98iiwsdFCU6Zw9GRzcLHn47c7Lo3gfumKFd1Nr6N0dQMaekOA0QTuGjelnj/tu4iURd/1l9oCjhgzO/RI6O33eyznQhx9v0DL8WBeXoawY3R5Hs+omdX29Fn92aFD4jRuU6wug8nOsaU= alieninochi@localdev"
#}

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
  value = aws_instance.webserver.*.public_ip
}