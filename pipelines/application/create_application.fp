pipeline "create_application" {
  title       = "Create Application"
  description = "Creates a new application to your Okta organization."

  param "api_token" {
    description = local.api_token_param_description
    type        = string
    default     = var.api_token
  }

  param "domain" {
    description = local.domain_param_description
    type        = string
    default     = var.domain
  }

  param "name" {
    description = "Unique key for the application definition."
    type        = string
  }

  param "label" {
    description = "User-defined display name for app."
    type        = string
  }

  param "sign_on_mode" {
    description = "Authentication mode for the app."
    type        = string
  }

  step "http" "create_application" {
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
    value       = step.http.create_application.response_body
    description = "Created application."
  }
}
