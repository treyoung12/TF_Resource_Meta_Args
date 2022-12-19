#terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

#resource block
resource "aws_instance" "my_server" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"

  # count will give us more than one server
  count = 2
  tags = {
    Name = "Server-${count.index}"
  }
}

#output block
output "public_ip" {
  value = aws_instance.my_server[*].public_ip # * gives you all of the ip's for the servers (2)
}
