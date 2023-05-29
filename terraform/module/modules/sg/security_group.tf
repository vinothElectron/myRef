resource "aws_security_group" "asg"{
  name="my-sg"
  description="testing modules"
  
  ingress{
    from_port=local.port
    to_port=local.port
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  egress{
    from_port=0
    to_port=0
    protocol="all"
    cidr_blocks=["0.0.0.0/0"]
  }
}
locals{
  port=8443
}
output "sg_id"{
  value=aws_security_group.asg.id
}
