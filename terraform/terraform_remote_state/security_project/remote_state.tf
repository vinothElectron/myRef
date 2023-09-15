data "terraform_remote_state" "trd"{
  backend="s3"
  config={
   bucket="backend-s3-vinoth"
   key="network/eip.tfstate"
   region="us-east-1"
}
}
