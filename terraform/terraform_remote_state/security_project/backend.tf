terraform {
  backend "s3"{
   bucket="backend-s3-vinoth"
   key="security/security.tf"
   region="us-east-1"
}
}
