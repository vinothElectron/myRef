provider "aws"{
  region="us-east-1"
}


resource "aws_instance" "aws_ec2"{
  ami="ami-0b0dcb5067f052a63"
  instance_type=lookup(var.instance_types,terraform.workspace)

}

variable "instance_types"{
  type=map
  default={
    default="t2.small"
    dev="t2.micro"
    prod="t2.large"
  }
}
