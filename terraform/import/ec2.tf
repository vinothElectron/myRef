resource "aws_instance" "myec2"{
  ami="ami-090e0fc566929d98b"
  instance_type="t2.micro"
  key_name="NFSKey"
  vpc_security_group_ids=["sg-067aec1f9cfc6d0f1"]
  tags={
    Name="Manual"
}
}
