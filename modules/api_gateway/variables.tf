

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

