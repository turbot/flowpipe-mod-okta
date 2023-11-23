pipeline "assign_group_to_application" {
  title       = "Group assignment to Application"
  description = "Assign a group to an application."

  param "api_token" {
    type        = string
    description = "The Okta personal access api_token to authenticate to the okta APIs."
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }

  param "group_id" {
    description = "The ID of a group."
    type        = string
  }

  param "app_id" {
    description = "ID of an application."
    type        = string
  }

  step "http" "assign_group_to_application" {
    method = "put"
    url    = "${param.domain}/api/v1/apps/${param.app_id}/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "groupAssignment" {
    description = "Group assignent details to an application."
    value       = step.http.assign_group_to_application.response_body
  }
}