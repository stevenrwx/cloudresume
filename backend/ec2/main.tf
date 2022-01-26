provider "aws" {
	region = "eu-west-2"
}

resource "aws_vpc" "main" {
	cidr_block = "10.1.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support = true
}

resource "aws_instance" "test" {
	ami = "ami-0fdbd8587b1cf431e"
	instance_type = "t2.micro"
}
