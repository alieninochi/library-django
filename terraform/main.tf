provider "aws" {
  region = "eu-central-1"
}

#resource "aws_db_instance" "app_db" {
#  instance_class = "db.t2.micro"
#  allocated_storage = 20
#  engine = "mysql"
#  engine_version = "8.0.27"
#  db_name = "testdb"
#  username = "admin"
#  password = "lbwldd27yta"
##  db_subnet_group_name = aws_subnet.ws_subnet.id
#  skip_final_snapshot = true
#}