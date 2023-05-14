resource "aws_iam_user" "lb"{
   name=var.user
   path="/system/"
}
