pipeline "list_assigned_groups" {
  title       = "List Assigned Groups"
  description = "Lists all group assignments for an application."

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

  step "http" "list_assigned_groups" {
    method = "get"
    url    = "${param.domain}/api/v1/apps/${param.app_id}/groups"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "application_groups" {
    value       = step.http.list_assigned_groups.response_body
    description = "List of assigned groups for the application."
  }
}
