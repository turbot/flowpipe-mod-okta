pipeline "update_application" {
  title       = "Update Application"
  description = "Update an application."

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

  param "name" {
    type        = string
    description = "Unique key for app definition."
    optional    = true
  }

  param "label" {
    type        = string
    description = "User-defined display name for app."
    optional    = true
  }

  param "sign_on_mode" {
    type        = string
    description = "Authentication mode of app."
    optional    = true
  }

  param "status" {
    type        = string
    description = "Status of app."
    optional    = true
  }

  step "http" "update_application" {
    method     = "put"
    url        = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }

    request_body = jsonencode({
      for name, value in param : try(local.application_common_param[name], name) => value if contains(keys(local.application_common_param), name) && value != null
    })
  }

  output "UpdatedApplication" {
    description = "Updated application details."
    value       = step.http.update_application.response_body
  }
}