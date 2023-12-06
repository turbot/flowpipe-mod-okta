pipeline "list_deactivated_users" {
  title       = "List Deactivated Users"
  description = "Lists all users that have a status of 'DEPROVISIONED'."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  # TODO: Add pagination once multiple response headers are returned
  step "http" "list_deactivated_users" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/users?limit=200&filter=status+eq+%22DEPROVISIONED%22"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "users" {
    description = "List of deactivated users."
    value       = step.http.list_deactivated_users.response_body
  }

}
