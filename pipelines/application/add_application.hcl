pipeline "add_application" {
  title       = "Add Application"
  description = "Create or Add an application."

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

  step "http" "add_application" {
    method = "post"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }

    request_body = jsonencode({
      for name, value in param : try(local.application_common_param[name], name) => value if contains(keys(local.application_common_param), name) && value != null
    })
  }

  output "application" {
    description = "Application Details"
    value       = step.http.add_application.response_body
  }
}
