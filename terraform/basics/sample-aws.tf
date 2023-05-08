provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "my-app" {
  ami           = "ami-08333bccc35d71140"
  instance_type = "t2.micro"
  tags={
   Name="sampple"
}
}
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    github = {
      source  = "integrations/github"
      version = "<=5.0"
    }
  }
}
provider "digitalocean" {}
