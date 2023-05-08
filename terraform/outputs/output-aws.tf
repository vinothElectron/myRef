provider "aws" {
  region = "us-east-1"
}
resource "aws_eip" "sip" {
  vpc = true
}
resource "aws_s3_bucket" "sb" {
  bucket = "random4545ggt"
  tags = {
    Name = "mybucket"
    ENV  = "DEV"
  }
}

output "ip" {
  value = aws_eip.sip
}
output "bucker_dns" {
  value = aws_s3_bucket.sb.bucket_domain_name
}
