pipeline "list_groups" {
  title       = "List Groups"
  description = "Lists all groups."

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

  step "http" "list_groups" {
    method = "get"
    url    = "${param.domain}/api/v1/groups?limit=10000"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "groups" {
    description = "List of groups."
    value       = step.http.list_groups.response_body
  }
}
