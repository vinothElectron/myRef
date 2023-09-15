provider "aws"{
region="us-east-1"
}
/*
data "local_file" "password"{
  filename="${path.module}/db_pass.txt"
}
resource "aws_db_instance" "mydb"{
  allocated_storage=10
  storage_type="gp2"
  db_name="vinoth"
  engine="mysql"
  engine_version="5.7"
  instance_class="db.t3.micro"
  username="admin"
  //password=data.local_file.password.content
  password=format("%q",file("./db_pass.txt"))
  //parameter_group_name="default.mysql5.7"
  skip_final_snapshot=true
}
*/
output "password"{
  value=chomp(file("./db_pass.txt"))
}


resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             =chomp(file("./db_pass.txt"))//chomp-->it removes newline charecter from end 
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
