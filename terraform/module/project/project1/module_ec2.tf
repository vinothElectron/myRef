module "aws_ec2"{
  source="../../modules/ec2"
  instance_type2="t2.large"
}
provider "aws"{
  region="us-east-1"
}
