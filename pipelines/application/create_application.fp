pipeline "create_application" {
  title       = "Create Application"
  description = "Creates a new application to your Okta organization."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "name" {
    type        = string
    description = "Unique key for the application definition."
  }

  param "label" {
    type        = string
    description = "User-defined display name for app."
  }

  param "sign_on_mode" {
    type        = string
    description = "Authentication mode for the app."
  }

  step "http" "create_application" {
    method = "post"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }

    request_body = jsonencode({
      for name, value in param : try(local.application_common_param[name], name) => value if contains(keys(local.application_common_param), name) && value != null
    })
  }

  output "application" {
    description = "Created application."
    value       = step.http.create_application.response_body
  }
}
