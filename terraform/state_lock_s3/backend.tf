terraform {
 backend "s3"{
  bucket="backend-s3-vinoth"
  key="network/sleep22.tfstate"
  region="us-east-1"
  dynamodb_table="state_lock"
 }
}
