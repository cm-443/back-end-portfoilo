#Provider
provider "aws" {
 region = "us-east-2"
}

terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"

   }
 }
}

#Lambda Function
resource "aws_iam_role" "iam_for_lambda" {
  name = var.lambda-iam-role

  assume_role_policy = <<EOF
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

#Lambda function
resource "aws_lambda_function" "example" {
  function_name    = var.lambda-name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.handler
  runtime          = var.lambda-runtime
  s3_bucket        = var.bucket-name
  s3_key           = var.bucket-key
}



#API Gateway
resource "aws_api_gateway_rest_api" "portfolio-api" {
  name        = var.api-name
  description = "Portfolio API"
    depends_on = [
    aws_lambda_function.example
  ]
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.portfolio-api.id
  parent_id   = aws_api_gateway_rest_api.portfolio-api.root_resource_id
  path_part   = "prod"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.portfolio-api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.portfolio-api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "https://${aws_api_gateway_rest_api.portfolio-api.id}.execute-api.${var.myregion}.amazonaws.com/prod/${aws_api_gateway_resource.resource.path}"
    depends_on = [
    aws_lambda_function.example
  ]
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.portfolio-api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
    depends_on = [
    aws_lambda_function.example
  ]
}

resource "aws_dynamodb_table" "table" {
  name           = var.db-name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "contactEmail"

  attribute {
    name = "contactEmail"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

}
