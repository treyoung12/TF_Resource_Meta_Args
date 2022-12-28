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
  
  # The lifecycle block and its contents are meta-arguments, available for all resource blocks regardless of type. Arguments says when things can/should be destroyed and changed and in what order
  lifecycle {
    # create_before_destroy = true
    prevent_destroy = true 
    # ignore_changes = []
    # replace_triggered_by = []
  }
}

#output block
output "public_ip" {
  value = aws_instance.my_server.public_ip
}
