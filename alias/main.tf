#terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}

# provider block
provider "aws" {
  profile = "default"
  region = "us-east-1"
  alias = "east"
}
provider "aws" {
  profile = "default"
  region = "us-west-2"
  alias = "west"
}

# ami data source block for linux 2
data "aws_ami" "amazon-linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

#resource block
resource "aws_instance" "my_east_server" {
  ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "t2.micro"
  provider = aws.east # references the provider via alias
  tags = {
    Name = "Server_east"
  }
}
resource "aws_instance" "my_west_server" {
  ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "t2.micro"
  provider = aws.west # references the provider via alias
  tags = {
    Name = "Server_west"
  }
}


#output block
output "east_public_ip" {
  value = aws_instance.my_east_server.public_ip # gives you ip for east server
}

output "west_public_ip" {
  value = aws_instance.my_west_server.public_ip # gives you ip for west server
}
