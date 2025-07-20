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



