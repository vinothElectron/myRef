provider "aws"{
  region="us-east-1"
}

module "new-sg"{
  source="../../modules/sg"
}

resource "aws_instance" "my-ec2"{
  ami="ami-0b0dcb5067f052a63"
  instance_type="t2.micro"
  vpc_security_group_ids=[module.new-sg.sg_id]
}
