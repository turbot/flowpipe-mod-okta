pipeline "list_users" {
  title       = "List Users"
  description = "Lists all users that do not have a status of 'DEPROVISIONED'."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  # TODO: Add pagination once multiple response headers are returned
  step "http" "list_users" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/users?limit=200"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "users" {
    description = "List of active users."
    value       = step.http.list_users.response_body
  }
}
