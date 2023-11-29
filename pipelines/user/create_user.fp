pipeline "create_user" {
  title       = "Create User"
  description = "Creates a new user in your Okta organization."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = local.domain_param_description
    default     = var.domain
  }

  param "first_name" {
    type        = string
    description = "Given name of the user."
  }

  param "last_name" {
    type        = string
    description = "The family name of the user."
  }

  param "email" {
    type        = string
    description = "The primary email address of the user."
  }

  param "login" {
    type        = string
    description = "The unique identifier for the user."
  }

  param "password" {
    type        = string
    description = "Specifies the password for a user."
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
    description = "Created user details."
    value       = step.http.create_user.response_body
  }
}
