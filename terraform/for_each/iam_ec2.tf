provider "aws"{
	region="us-east-1"
}
variable "users"{
 type=list
 default=["first","second"]
}
resource "aws_iam_user" "aiu"{
   for_each=toset(var.users)
   name=each.key
}
resource "aws_instance" "ec2"{
   ami="ami-0b0dcb5067f052a63"
   for_each={
	key1="t2.micro"
  	key2="t2.small"
   }
   instance_type=each.value
   key_name=each.key
   tags={
       key=each.key
    }
}
