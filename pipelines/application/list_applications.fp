pipeline "list_applications" {
  title       = "List Applications"
  description = "Lists all applications."

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

  step "http" "list_applications" {
    method = "get"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "applications" {
    value       = step.http.list_applications.response_body
    description = "List of applications."
  }
}
