pipeline "get_user" {
  title       = "Retrieve User"
  description = "Retrieves a user from your Okta organization."

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

  step "http" "get_user" {
    method = "get"
    url    = "${param.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "user" {
    value       = step.http.get_user.response_body
    description = "User details."
  }
}
