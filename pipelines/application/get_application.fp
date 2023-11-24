pipeline "get_application" {
  title       = "Retrieve Application"
  description = "Retrieves an application from your Okta organization by id."

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

  step "http" "get_application" {
    method = "get"
    url    = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "application" {
    value       = step.http.get_application.response_body
    description = "Application details."
  }
}
