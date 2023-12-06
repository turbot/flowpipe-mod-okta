pipeline "list_groups" {
  title       = "List Groups"
  description = "Lists all groups."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  # TODO: Add pagination once multiple response headers are returned
  step "http" "list_groups" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/groups?limit=10000"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "groups" {
    description = "List of groups."
    value       = step.http.list_groups.response_body
  }
}
