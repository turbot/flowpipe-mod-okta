pipeline "update_application" {
  title       = "Update Application"
  description = "Update an application."

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

  param "app_id" {
    description = "ID of an application."
    type        = string
  }

  param "name" {
    type        = string
    description = "Unique key for app definition."
    default     = ""
  }

  param "label" {
    type        = string
    description = "User-defined display name for app."
    default     = ""
  }

  param "sign_on_mode" {
    type        = string
    description = "Authentication mode of app."
    default     = ""
  }

  param "status" {
    type        = string
    description = "Status of app."
    default     = ""
  }

  step "pipeline" "get_app_details" {
    pipeline = pipeline.get_application
    args = {
      app_id = param.app_id
    }
  }

  step "http" "update_app" {
    depends_on = [step.pipeline.get_app_details]
    method     = "put"
    url        = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }

    request_body = jsonencode({
      name       = (param.name != "" ? param.label : jsondecode(step.pipeline.get_app_details.application)["label"])
      label      = (param.label != "" ? param.label : jsondecode(step.pipeline.get_app_details.application)["label"])
      signOnMode = (param.sign_on_mode != "" ? param.sign_on_mode : jsondecode(step.pipeline.get_app_details.application)["signOnMode"])
      status     = (param.status != "" ? param.status : jsondecode(step.pipeline.get_app_details.application)["status"])

    })
  }

  output "UpdatedApplication" {
    description = "Updated application details."
    value       = step.http.update_app.response_body
  }
}