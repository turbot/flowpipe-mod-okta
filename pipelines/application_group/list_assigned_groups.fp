pipeline "list_assigned_groups" {
  title       = "List Assigned Groups"
  description = "Lists all group assignments for an application."

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

  param "app_id" {
    type        = string
    description = local.application_id_param_description
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
    description = "List of assigned groups for the application."
    value       = step.http.list_assigned_groups.response_body
  }
}
