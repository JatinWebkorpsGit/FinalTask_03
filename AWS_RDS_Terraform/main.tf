terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.17.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}


resource "random_id" "name" {
  byte_length = 8
}

resource "aws_security_group" "name" {
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    ENV = "PROD"
  }
}

resource "aws_db_instance" "myDB" {

  identifier = "my-sql-db"
  db_name = "MY_DB"
  instance_class = "db.t4g.micro"
  username = "JATIN"
  engine = "mysql"
  engine_version = "8.0.43"
  allocated_storage = "10"
  password = "rootroot"
  skip_final_snapshot = true
  vpc_security_group_ids = [ aws_security_group.name.id ]
  tags = {

    Name= "MY_SQL_DB"
    Env = "PROD"
  }
  publicly_accessible = true
}

output "endpoint" {
  value = aws_db_instance.myDB.endpoint
}