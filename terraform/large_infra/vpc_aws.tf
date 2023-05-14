provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "large-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  tags = {
    terraform = true
  }
}

resource "aws_security_group" "asg" {
  name        = "large-asg"
  description = "large infra"
  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["44.199.255.17/32"]
  }
  ingress{
    from_port=443
    to_port=443
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  egress {
    to_port     = 65535
    from_port   = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_instance" "ai" {
  ami              = "ami-0b0dcb5067f052a63"
  instance_type    = "t2.small"
  vpc_security_group_ids = [aws_security_group.asg.id]
}
