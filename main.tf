provider "aws" {
  region = var.aws_region
}

module "lambda_notification" {
  source = "./modules/lambda"
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "cognito" {
  source = "./modules/cognito"
}