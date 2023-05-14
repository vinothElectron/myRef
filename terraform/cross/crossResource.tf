provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sec" {
  name = "terra-sg"
  ingress {
    description = "sample"
    from_port   = 443
    to_port     = 443
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/32"]
  }
}
resource "aws_eip" "elas" {
  //instance = aws_instance.ins.id //it working
  vpc      = true
}


resource "aws_instance" "ins" {
  ami             = "ami-0b0dcb5067f052a63"
  instance_type   = "t2.micro"
  //vpc_security_group_ids = [aws_security_group.sec.id]//working
}

//attach eip with ec2
resource "aws_eip_association" "eia"{
	instance_id=aws_instance.ins.id
	allocation_id=aws_eip.elas.id
}
//attach sg with ec2
resource "aws_network_interface_sg_attachment" "sg_attach"{
  security_group_id=aws_security_group.sec.id
  network_interface_id=aws_instance.ins.primary_network_interface_id
}

