pipeline "list_users" {
  title       = "List Users"
  description = "List users."

  param "api_token" {
    type        = string
    description = "The Okta personal access api_token to authenticate to the okta APIs."
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
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
    description = "Details of the users."
    value       = step.http.list_users.response_body
  }
}
