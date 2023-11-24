pipeline "assign_group" {
  title       = "Assign Group"
  description = "Assigns a group to an application."

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

  param "group_id" {
    description = local.group_id_param_description
    type        = string
  }

  param "app_id" {
    description = local.application_id_param_description
    type        = string
  }

  step "http" "assign_group" {
    method = "put"
    url    = "${param.domain}/api/v1/apps/${param.app_id}/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "application_group" {
    value       = step.http.assign_group.response_body
    description = "The assigned group."
  }
}