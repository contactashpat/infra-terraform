# modules/lambda/main.tf
resource "aws_iam_role" "lambda_exec" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "notification" {
  filename         = var.lambda_package_path
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.lambda_handler
  source_code_hash = filebase64sha256(var.lambda_package_path)
  runtime          = var.lambda_runtime
  timeout          = 10

  environment {
    variables = var.lambda_env_vars
  }
}

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

# modules/api_gateway/main.tf
resource "aws_apigatewayv2_api" "http_api" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_uri
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /notifications"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = var.authorizer_id
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

# modules/api_gateway/variables.tf
variable "api_name" {
  description = "Name of the HTTP API"
  type        = string
}

variable "lambda_uri" {
  description = "Lambda function URI to integrate with API Gateway"
  type        = string
}

variable "authorizer_id" {
  description = "JWT Authorizer ID for securing the route"
  type        = string
}
