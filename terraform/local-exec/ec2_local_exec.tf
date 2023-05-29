provider "aws"{
  region="us-east-1"
}
/*
resource "aws_instance" "my-ec2"{
  ami="ami-0b0dcb5067f052a63"
  instance_type="t2.micro"
  
  provisioner "local-exec"{
     on_failure=continue
     command= "eicho ${self.public_ip} >> public_ips.txt"
  }
  provisioner "local-exec"{
     when=destroy
     command=" sed '/${self.public_ip}/d' -i public_ips.txt"
  }
}
*/
