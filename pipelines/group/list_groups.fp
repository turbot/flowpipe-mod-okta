pipeline "list_groups" {
  title       = "List Groups"
  description = "Lists all groups."

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

  step "http" "list_groups" {
    method = "get"
    url    = "${param.domain}/api/v1/groups"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "groups" {
    value       = step.http.list_groups.response_body
    description = "List of groups."
  }
}
