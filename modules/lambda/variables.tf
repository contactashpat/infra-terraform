# modules/lambda/variables.tf
variable "lambda_package_path" {
  description = "Path to the zipped Lambda deployment package"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "Handler for the Lambda function"
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
}

variable "lambda_env_vars" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "lambda_role_name" {
  description = "Name for the IAM role to be assumed by the Lambda function"
  type        = string
}
