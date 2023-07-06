 terraform{
  backend "s3"{
   bucket="backend-s3-vinoth"
   key="network/eip.tfstate"
   region="us-east-1"
}
}
