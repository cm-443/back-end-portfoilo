#API name
variable "api-name" {
 description = "API name"
 type        = string
 default     = "portfolio-api"
}

#API Role Vars
#Region
variable "myregion" {
 description = "region for api"
 type        = string
 default     = "us-east-2"
}

#account ID
variable "accountId" {
 description = "Account ID for API"
 type        = string
 default     = "THIS SHOULD BE STORED IN AWS SECRETS MANAGER"
}

#S3 bucket for lambda
variable "bucket-name" {
 description = "S3 for lambda"
 type        = string
 default     = "lambda-functions-cm443"
}

#S3 bucket key for lambda 
variable "bucket-key" {
 description = "S3 key for lambda"
 type        = string
 default     = "main.zip"
}

#Lambda iam role name
variable "lambda-iam-role" {
 description = "Name of lambda iam role"
 type        = string
 default     = "portfolio-lambda-role"
}


#Lambda function name
variable "lambda-name" {
 description = "Name of lambda function"
 type        = string
 default     = "portfolio-lambda"
}

#Lambda handler name 
variable "handler" {
 description = "handler name"
 type        = string
 default     = "main.lambda_handler"
}

#Lambda runtime
variable "lambda-runtime" {
 description = "Lambda runtime"
 type        = string
 default     = "python3.9"
}

#DB Name
variable "db-name" {
 description = "DB Name"
 type        = string
 default     = "portfolio-db"
}
