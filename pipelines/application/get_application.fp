pipeline "get_application" {
  title       = "Retrieve Application"
  description = "Retrieves an application from your Okta organization by id."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  step "http" "get_application" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps/${param.app_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "application" {
    description = "Application details."
    value       = step.http.get_application.response_body
  }
}
