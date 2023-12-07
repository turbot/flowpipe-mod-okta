pipeline "delete_application" {
  title       = "Delete Application"
  description = "Deletes an inactive application."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  step "http" "delete_application" {
    method = "delete"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }
}
