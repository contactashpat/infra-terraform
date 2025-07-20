# modules/cognito/main.tf
resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name
}

resource "aws_cognito_user_pool_client" "this" {
  name         = var.client_name
  user_pool_id = aws_cognito_user_pool.this.id

  allowed_oauth_flows = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = ["openid"]
  supported_identity_providers = ["COGNITO"]
  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls
  generate_secret = false
}
