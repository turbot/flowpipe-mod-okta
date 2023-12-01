pipeline "get_user" {
  title       = "Retrieve User"
  description = "Retrieves a user from your Okta organization."

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

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "get_user" {
    method = "get"
    url    = "${param.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "user" {
    description = "User details."
    value       = step.http.get_user.response_body
  }
}
