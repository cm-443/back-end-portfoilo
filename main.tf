


#Back end resources
########################################
#API Gateway
resource "aws_apigatewayv2_api" "example" {
  name          = "example-http-api"
  protocol_type = "HTTP"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api


#Lambda Function
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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
  role             = aws_iam_role.example.arn
  handler          = var.handler
  runtime          = var.lambda-runtime
  s3_bucket        = var.bucket-name
  s3_key           = var.bucket-key
}


#DynamoDB
resource "aws_dynamodb_table" "table" {
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "contactName"
    type = "S"
  }

  attribute {
    name = "contactEmail"
    type = "S"
  }

  attribute {
    name = "contactSubject"
    type = "S"
  }


    attribute {
    name = "contactMessage"
    type = "S"
  }


  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }


}