pipeline "update_application" {
  title       = "Update Application"
  description = "Replaces an application."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  param "name" {
    type        = string
    description = "Unique key for the application definition."
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
    description = "App instance status."
    optional    = true
  }

  step "pipeline" "get_application" {
    pipeline = pipeline.get_application
    args = {
      cred   = param.cred
      app_id = param.app_id
    }
  }

  step "http" "update_application" {
    depends_on = [step.pipeline.get_application]

    method = "put"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps/${param.app_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }

    request_body = jsonencode({
      name          = coalesce(param.name, step.pipeline.get_application.output.application.name)
      label         = coalesce(param.label, step.pipeline.get_application.output.application.label)
      status        = coalesce(param.status, step.pipeline.get_application.output.application.status)
      accessibility = step.pipeline.get_application.output.application.accessibility
      visibility    = step.pipeline.get_application.output.application.visibility
      features      = step.pipeline.get_application.output.application.features
      signOnMode    = coalesce(param.sign_on_mode, step.pipeline.get_application.output.application.signOnMode)
      credentials   = step.pipeline.get_application.output.application.credentials
      settings      = step.pipeline.get_application.output.application.settings
    })
  }

  output "application" {
    description = "Updated application details."
    value       = step.http.update_application.response_body
  }
}
