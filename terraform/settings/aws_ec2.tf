terraform{
  required_version=">= 1.0"
}

provider "aws"{
  region="us-east-1"
}
resource "aws_iam_user" "aim"{
  name="user_${count.index}"
  count=3
  path="/system/dev/"
}
output "name"{
  value=aws_iam_user.aim[*].name
}
output "arn"{
  value=aws_iam_user.aim[*].arn
}
