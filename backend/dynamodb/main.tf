provider "aws" {
	region = "eu-west-2"
	shared_credentials_file = "~/.aws/credentials"
	profile = "default"
}
resource "aws_dynamodb_table" "visits" {
	name = "VistorCount"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "count"
	
	attribute {
	name = "count"
	type = "N"
   }

}
