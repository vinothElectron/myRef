resource "aws_eip" "ip"{
  vpc=true
  count=3
  //depends_on=[null_resource.resource]
}

resource "null_resource" "resource"{
  triggers={
    my_ip=join(",",aws_eip.ip[*].public_ip)
  }
  provisioner "local-exec"{
    command ="echo my public ips ${self.triggers.my_ip} >ips.txt"
  }
}
