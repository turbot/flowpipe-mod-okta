pipeline "list_user" {
  title       = "List Users"
  description = "List users."

  param "token" {
    type        = string
    description = "The Okta personal access token to authenticate to the okta APIs."
    default     = var.token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }

  step "http" "list_user" {
    method = "get"
    url    = "${param.domain}/api/v1/users?limit=200"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }

  output "users" {
    description = "User details."
    value       = step.http.list_user.response_body
  }
}
