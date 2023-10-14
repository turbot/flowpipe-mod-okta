pipeline "list_applications" {
  title       = "List Applications"
  description = "List applications."

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

  step "http" "list_applications" {
    method = "get"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "applications" {
    description = "Applications details."
    value       = step.http.list_applications.response_body
  }
}
