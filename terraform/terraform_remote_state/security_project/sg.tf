resource "aws_security_group" "rs"{
  description="remote state"
  name="whitelist"
  ingress{
   to_port="80"
   from_port=80
   protocol="tcp"
   cidr_blocks=["${data.terraform_remote_state.trd.outputs.public_ip}/32"]
 }
}
