provider "aws" {
  region = var.aws_region
}

module "lambda_notification" {
  source = "./modules/lambda"
  lambda_function_name = ""
  lambda_handler = ""
  lambda_package_path = ""
  lambda_role_name = ""
  lambda_runtime = ""
}

module "api_gateway" {
  source = "./modules/api_gateway"
  api_name = ""
  authorizer_id = ""
  lambda_uri = ""
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "cognito" {
  source = "./modules/cognito"
  callback_urls = []
  client_name = ""
  logout_urls = []
  user_pool_name = ""
}
