terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
variable "region" {
  default = "us-east-1"
}
variable "amis" {
  type = map(any)
  default = {
    "us-east-1" = "ami-0b0dcb5067f052a63"
    "us-west-1" = "ami-051ed863837a0b1b6"
    "us-east-2" = "ami-08333bccc35d71140"
  }
}
variable "names" {
  type    = list(any)
  default = ["firstI", "secondI"]
}
locals{
  time=formatdate("DD MMM YYYY hh:mm ZZZ",timestamp())
}
resource "aws_key_pair" "aws_key" {
  key_name   = "my-key"
  public_key = file("${path.module}/id_rsa.pub")
}
resource "aws_security_group" "aws_sg" {
  name        = "function_sg"
  description = "to test"

  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0"]
  }
}
resource "aws_instance" "aws_instance" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  count                  = 2
  key_name               = aws_key_pair.aws_key.key_name
  vpc_security_group_ids = [aws_security_group.aws_sg.id]


  tags = {
    Name = element(var.names, count.index)
  }
}

output "current"{
  value=local.time
}
