pipeline "update_user" {
  title       = "Update User"
  description = "Replaces a user's profile using strict-update semantics."

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

  param "user_id" {
    description = local.user_id_param_description
    type        = string
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

  step "http" "update_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }

    request_body = jsonencode({
      profile = {
        for name, value in param : try(local.user_common_param[name], name) => value if contains(keys(local.user_common_param), name) && value != null
      }
    })
  }

  output "user" {
    value       = step.http.update_user.response_body
    description = "Updated user details."
  }
}
