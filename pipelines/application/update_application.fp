pipeline "update_application" {
  title       = "Replace Application"
  description = "Replaces an application."

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

  param "app_id" {
    description = local.application_id_param_description
    type        = string
  }

  param "name" {
    description = "Unique key for the application definition."
    type        = string
    optional    = true
  }

  param "label" {
    description = "User-defined display name for app."
    type        = string
    optional    = true
  }

  param "sign_on_mode" {
    description = "Authentication mode of app."
    type        = string
    optional    = true
  }

  param "status" {
    description = "App instance status."
    type        = string
    optional    = true
  }

  step "http" "update_application" {
    method = "put"
    url    = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }

    request_body = jsonencode({
      for name, value in param : try(local.application_common_param[name], name) => value if contains(keys(local.application_common_param), name) && value != null
    })
  }

  output "application" {
    value       = step.http.update_application.response_body
    description = "Updated application details."
  }
}