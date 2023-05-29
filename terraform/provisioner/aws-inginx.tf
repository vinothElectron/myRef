provider "aws" {
  region = "us-east-1"
}
resource "aws_key_pair" "key"{
  key_name="my-key"
  public_key=file("${path.module}/id_rsa.pub")
}
resource "aws_instance" "nginx_1" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name      =aws_key_pair.key.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./id_rsa")
    }
  }
}
output "public_ip"{
  value=aws_instance.nginx_1.public_ip
}
