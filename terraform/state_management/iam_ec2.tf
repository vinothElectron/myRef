provider "aws"{
  region="us-east-1"
}

resource "aws_iam_user" "user1"{
  name="lb_user"
  path="/system/"
}
resource "aws_instance" "lb"{
  ami="ami-0b0dcb5067f052a63"
  instance_type="t2.micro"
}

terraform{
  backend "s3"{
    bucket="backend-s3-vinoth"
    key="network/state_management.tfstate"
    region="us-east-1"
    dynamodb_table="state_lock"
  }
}
