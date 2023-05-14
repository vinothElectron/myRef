provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_user" "iam" {
  name  = "user_${count.index}"
  count = 3
  path  = "/system/"
}
output "users_arn" {
  value = aws_iam_user.iam[*].arn
}
