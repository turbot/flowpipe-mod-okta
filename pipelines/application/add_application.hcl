pipeline "add_application" {
  title       = "Create/Add Application"
  description = "Create or Add an application."

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

  param "name" {
    description = "Unique key for app definition."
    type        = string
  }

  param "label" {
    description = "User-defined display name for app."
    type        = string
  }

  param "sign_on_mode" {
    description = "Authentication mode of app."
    type        = string
  }

  step "http" "add_app" {
    method = "post"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }

    request_body = jsonencode({
      name       = "${param.name}"
      label      = "${param.label}"
      signOnMode = "${param.sign_on_mode}"
    })
  }

  output "application" {
    description = "Application Details"
    value       = step.http.add_app.response_body
  }
}
