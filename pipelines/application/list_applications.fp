pipeline "list_applications" {
  title       = "List Applications"
  description = "Lists all applications."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  # TODO: Add pagination once multiple response headers are returned
  step "http" "list_applications" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps?limit=1"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "applications" {
    description = "List of applications."
    value       = step.http.list_applications.response_body
  }
}
