provider "aws" {
  region = "us-east-1"
}
variable "ports" {
  type        = list(number)
  description = "ports to add in sg"
  default     = ["443", "80", "22"]
}
resource "aws_security_group" "my_sg" {
  name        = "dynamic"
  description = "dynamic block sg"
  dynamic "ingress" {
    for_each = var.ports
    content {
      to_port     = ingress.value
      from_port   = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress"{
    for_each=var.ports
    iterator=port
    content{
	to_port=port.value
        from_port=port.value
	protocol="tcp"
	cidr_blocks=["0.0.0.0/0"]
    }
  }
}
