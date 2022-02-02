provider "aws" {
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

resource "aws_api_gateway_rest_api" "vistorapi" {
    name = "vistorapi"
}

resource "aws_api_gateway_resource" "vistorapi" {
    parent_id = aws_api_gateway_rest_api.vistorapi.root_resource_id
    path_part = "vistorapi"
    rest_api_id = aws_api_gateway_rest_api.vistorapi.id
}

resource "aws_api_gateway_method" "vistorapi" {
    authorization = "NONE"
    http_method = "GET"
    resource_id = aws_api_gateway_resource.vistorapi.id
    rest_api_id = aws_api_gateway_rest_api.vistorapi.id
}


