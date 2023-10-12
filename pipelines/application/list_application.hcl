pipeline "list_application" {
  title       = "List Application"
  description = "List applications."

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

  // Kept here for future paging use
  param "app_limit" {
    type    = number
    default = 200
  }

  step "http" "list_app" {
    method = "get"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }


  output "applications" {
    description = "Applications details."
    value       = step.http.list_app.response_body
  }
}
