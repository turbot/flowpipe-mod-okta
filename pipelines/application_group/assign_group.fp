pipeline "assign_group" {
  title       = "Assign Group"
  description = "Assigns a group to an application."

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

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
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
    description = "The assigned group."
    value       = step.http.assign_group.response_body
  }
}