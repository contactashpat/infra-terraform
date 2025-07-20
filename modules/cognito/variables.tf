# modules/cognito/variables.tf
variable "user_pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
}

variable "client_name" {
  description = "The name of the User Pool client"
  type        = string
}

variable "callback_urls" {
  description = "OAuth2 callback URLs for Cognito client"
  type        = list(string)
}

variable "logout_urls" {
  description = "OAuth2 logout URLs for Cognito client"
  type        = list(string)
}
