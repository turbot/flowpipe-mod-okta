pipeline "list_deactivated_users" {
  title       = "List Deactivated Users"
  description = "Lists all users that have a status of 'DEPROVISIONED'."

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

  step "http" "list_deactivated_users" {
    method = "get"
    url    = "${param.domain}/api/v1/users?filter=status+eq+%22DEPROVISIONED%22"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "users" {
    value       = step.http.list_deactivated_users.response_body
    description = "List of deactivated users."
  }

}
