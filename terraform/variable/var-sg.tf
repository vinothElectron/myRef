provider "aws" {
  region = "us-east-1"
}
resource "aws_security_group" "asg" {
  name = "security"
  ingress {
    description = "test"
    to_port     = 443
    from_port   = 443
    protocol    = "tcp"
    cidr_blocks = [var.whitelist]
  }
  ingress {
    description = "test"
    to_port     = 43
    from_port   = 43
    protocol    = "tcp"
    cidr_blocks = [var.whitelist]
  }
  ingress {
    description = "test"
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = [var.whitelist]
  }
}
