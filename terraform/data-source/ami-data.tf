provider "aws" {
  region="us-east-1"
}
data "aws_instance" "instance"{
  instance_id="i-065ec9f8b926d40ff"
  filter{
    name="image-id"
    values=["ami-0b0dcb5067f05*"]
  }
}
data "aws_ami" "ami"{
  most_recent=true
  owners=["amazon"]
  filter{
	name="name"
	values=["amzn-ami-hvm*"]
  }
}
resource "aws_instance" "ai"{
  ami=data.aws_ami.ami.id
  instance_type="t2.micro"
}
output "ami"{
 value=data.aws_ami.ami
}
output "instances"{
  value=data.aws_instance.instance.tags
}
