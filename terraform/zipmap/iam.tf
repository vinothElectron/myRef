provider "aws"{
  region="us-east-1"
}
#list of users
variable "users"{
  type=list
  default=["zero","first","second","third","fouth"]
}
resource "aws_iam_user" "aiu"{
  name=var.users[count.index]
  path="/system/"
  count=5
}
output "users"{
  value=aws_iam_user.aiu[*].name
}
output "arn"{
  value=aws_iam_user.aiu[*].arn
}

output "map"{
  value=zipmap(aws_iam_user.aiu[*].name,aws_iam_user.aiu[*].arn)
}

