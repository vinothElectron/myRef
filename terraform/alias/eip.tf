resource "aws_eip" "eip1"{
  vpc=true
}
resource "aws_eip" "eip2"{
  provider=aws.ohio
  vpc=true
}
