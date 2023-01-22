#name          = "example-http-api"

variable "api-name" {
 description = "API name"
 type        = string
 default     = "portfolio-api"
}

##################################################
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

#Lambda function name
variable "lambda-name" {
 description = "Name of lambda function"
 type        = string
 default     = "portfolio-api"
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

################################################

#DB Name

variable "db-name" {
 description = "Lambda runtime "
 type        = string
 default     = "portfolio-api"
}