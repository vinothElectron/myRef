provider "aws"{
  region="us-east-1"
}
module "registry"{
  source="terraform-aws-modules/ec2-instance/aws"

 name="registry"
  instance_type="t2.micro"
  key_name="NFSKey"
  subnet_id="subnet-046bf86a4a0fcb1da"
  tags={
     terraform=true
     key="nfskey"
  }
  

}
