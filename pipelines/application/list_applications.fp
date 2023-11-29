pipeline "list_applications" {
  title       = "List Applications"
  description = "Lists all applications."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = local.domain_param_description
    default     = var.domain
  }

  step "http" "list_applications" {
    method = "get"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "applications" {
    description = "List of applications."
    value       = step.http.list_applications.response_body
  }
}
