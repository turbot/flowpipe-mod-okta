pipeline "list_users" {
  title       = "List Users"
  description = "Lists all users that do not have a status of 'DEPROVISIONED'."

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

  step "http" "list_users" {
    method = "get"
    url    = "${param.domain}/api/v1/users?limit=200"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "users" {
    value       = step.http.list_users.response_body
    description = "List of active users."
  }
}
