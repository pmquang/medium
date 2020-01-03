provider "aws" {
  region = "us-east-1"
}
data "aws_ami" "amazon-ami" {
  most_recent = true
filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*"]
  }
filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
owners = ["amazon"]
}
resource "aws_instance" "aws-instance-example" {
  ami           = "${data.aws_ami.amazon-ami.id}"
  instance_type = "t2.micro"
tags = {
    Name = "Hello-World"
  }
}
