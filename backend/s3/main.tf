provider "aws" {
	region = "eu-west-2"
	shared_credentials_file = "~/.aws/credentials"
	profile = "default"
}

resource "aws_s3_bucket" "steven-website-01" {
	bucket = "steven-website-01"
	acl = "private"
	policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [{
    "Sid": "AllowPublicRead",
    "Effect": "Allow",
    "Principal": {
      "AWS": "*"
    },
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::steven-website-01/*"
  }]
}
EOF
}
