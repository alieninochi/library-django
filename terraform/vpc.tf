resource "aws_vpc" "vpc_for_web" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "vpc for web server"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_for_web.id

  tags = {
    name = "igw for web server"
  }
}

resource "aws_route_table" "web_route" {
  vpc_id = aws_vpc.vpc_for_web.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    name = "routing rules for web server"
  }
}

resource "aws_subnet" "ws_subnet" {
  vpc_id = aws_vpc.vpc_for_web.id
  cidr_block = "10.0.100.0/24"
  map_public_ip_on_launch = true


  tags = {
    name = "public subnet for web server"
  }
}

resource "aws_route_table_association" "a" {
  route_table_id = aws_route_table.web_route.id
  subnet_id = aws_subnet.ws_subnet.id
}