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
# makes the resource depend on the creation of another resource first before it can be staged (bucket is created before the instance)
  depends_on = [
    aws_s3_bucket.bucket
  ]
}

#output block
output "public_ip" {
  value = aws_instance.my_server.public_ip
}

# s3 bucket resource block
resource "aws_s3_bucket" "bucket" {
  bucket = "6849821bucketname"

}
