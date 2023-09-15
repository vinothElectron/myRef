terraform{
  backend "s3"{
    bucket="backend-s3-vinoth"
    key="Network/terraform.tfstate"
    region="us-east-1"
  }
}
