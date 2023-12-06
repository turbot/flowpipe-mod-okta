pipeline "list_assigned_groups" {
  title       = "List Assigned Groups"
  description = "Lists all group assignments for an application."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  # TODO: Add pagination once multiple response headers are returned
  step "http" "list_assigned_groups" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps/${param.app_id}/groups?limit=200"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "application_groups" {
    description = "List of assigned groups for the application."
    value       = step.http.list_assigned_groups.response_body
  }
}
