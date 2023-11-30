pipeline "list_deactivated_users" {
  title       = "List Deactivated Users"
  description = "Lists all users that have a status of 'DEPROVISIONED'."

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

  # TODO: Add pagination once multiple response headers are returned
  step "http" "list_deactivated_users" {
    method = "get"
    url    = "${param.domain}/api/v1/users?limit=200&filter=status+eq+%22DEPROVISIONED%22"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "users" {
    description = "List of deactivated users."
    value       = step.http.list_deactivated_users.response_body
  }

}
