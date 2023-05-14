provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ais" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
}
resource "aws_eip" "aelb" {
  instance = aws_instance.ais.id
  vpc=true
}
resource "aws_security_group" "asg" {
  name        = "asg"
  description = "check graph"
  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.aelb.private_ip}/32"]
  }
}
