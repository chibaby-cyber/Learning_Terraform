provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

variable "subnet_cidr_block" {
    description = "subnet cidr block"  
}

resource "aws_vpc" "development_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "development"
    vpcenv: "dev"
  }
}
resource "aws_subnet" "dev_subnet_1" {
    vpc_id = aws_vpc.development_vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = "us-east-1a"
    tags = {
        Name: "subnet-dev-1"
    }
  
}
data "aws_vpc" "existing_vpc" {
    default = true
}
resource "aws_subnet" "dev_subnet_2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.80.0/20"
    availability_zone = "us-east-1a"
    tags = {
        Name: "subnet-default-2"
    }
}
output "dev-vpc-id" {
    value = aws_vpc.development_vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev_subnet_1.id
}