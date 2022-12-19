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
  instance_type = each.value

  # for_each iterates through and changes some particular property (a terraform plan creates 3 isntances with the names 'micro, nano, and small' with the properties associated with them)
  for_each = {
    micro = "t2.micro"
    nano = "t2.nano"
    small = "t2.small"
  }
  tags = {
    Name = "Server-${each.key}"
  }
}

#output block
output "public_ip" {
  value = values(aws_instance.my_server)[*].public_ip 
}
