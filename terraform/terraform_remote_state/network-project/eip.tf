resource "aws_eip" "myeip"{
  vpc=true
}
output "public_ip"{
  value=aws_eip.myeip.public_ip
}
