pipeline "delete_application" {
  title       = "Delete Application"
  description = "Deletes an inactive application."

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

  step "http" "delete_application" {
    method = "delete"
    url    = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
