provider "aws"{
//  region="us-east-1"
} 

module "aws_ec2_from_github"{
  source="github.com/vinothElectron/MyNotes.git?ref=main"
  isTest=true
}
