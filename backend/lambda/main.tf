provider "aws" {
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_iam_role" "iam_for_lambda" {
  name                = "iam_for_lambda"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"]
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_lambda_function" "main" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.9"
}
resource "aws_lambda_permission" "allow_api" {
  statement_id  = "AllowAPIgatewayInvokation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.vistorapi.execution_arn}/*/*/*"
}
resource "aws_api_gateway_rest_api" "vistorapi" {
  name = "vistorapi"
}

resource "aws_api_gateway_resource" "vistorapi" {
  parent_id   = aws_api_gateway_rest_api.vistorapi.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.vistorapi.id #
  path_part   = "vistorapi"
}

resource "aws_api_gateway_method" "vistorapi" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.vistorapi.id
  rest_api_id   = aws_api_gateway_rest_api.vistorapi.id
}

resource "aws_api_gateway_integration" "vistorapi_integration" {
  rest_api_id             = aws_api_gateway_rest_api.vistorapi.id
  resource_id             = aws_api_gateway_resource.vistorapi.id
  http_method             = aws_api_gateway_method.vistorapi.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main.invoke_arn
}
resource "aws_api_gateway_deployment" "vistorapi" {
  rest_api_id = aws_api_gateway_rest_api.vistorapi.id
  stage_name  = "api"
}

output "deployement_invoke_url" {
  description = "base url of api gateway remember to add pathpart /vistorapi"
  value       = aws_api_gateway_deployment.vistorapi.invoke_url
}
