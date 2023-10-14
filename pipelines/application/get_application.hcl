pipeline "get_application" {
  title       = "Get Application"
  description = "Get an application by ID."

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

  param "app_id" {
    description = "ID of an application."
    type        = string
  }

  step "http" "get_app" {
    method = "get"
    url    = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "application" {
    description = "Application details."
    value       = step.http.get_app.response_body
  }
}
