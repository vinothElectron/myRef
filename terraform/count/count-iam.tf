terraform{
  required_providers{
     source="hashicorp/aws"
  }
}
//provider "aws" {}
/*
resource "aws_iam_user" "user" {
  name  = var.users[count.index]
  path  = "/system/"
  count = 3
}
variable "users"{
  type=list
  default=["dev-load","qa-load","prod-load"]
}*/
variable "isTest" {}

locals{
  tags={
    Application="java"
    db="oracle"
}
}
resource "aws_instance" "dev" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  count         = var.isTest == true ? 1 : 0
  tags=local.tags
}
resource "aws_instance" "prod" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.large"
  count         = var.isTest == false ? 1 : 0
  tags=local.tags
}
