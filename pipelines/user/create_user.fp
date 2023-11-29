pipeline "create_user" {
  title       = "Create User"
  description = "Creates a new user in your Okta organization."

  param "api_token" {
    description = local.api_token_param_description
    type        = string
    default     = var.api_token
  }

  param "domain" {
    description = local.domain_param_description
    type        = string
    default     = var.domain
  }

  param "first_name" {
    description = "Given name of the user."
    type        = string
  }

  param "last_name" {
    description = "The family name of the user."
    type        = string
  }

  param "email" {
    description = "The primary email address of the user."
    type        = string
  }

  param "login" {
    description = "The unique identifier for the user."
    type        = string
  }

  param "password" {
    description = "Specifies the password for a user."
    type        = string
  }

  // Create user with password
  step "http" "create_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users?nextLogin=changePassword"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }

    request_body = jsonencode({
      profile = {
        firstName = param.first_name
        lastName  = param.last_name
        email     = param.email
        login     = param.login
      }
      credentials = {
        password = param.password
      }
    })
  }

  output "user" {
    value       = step.http.create_user.response_body
    description = "Created user details."
  }
}
