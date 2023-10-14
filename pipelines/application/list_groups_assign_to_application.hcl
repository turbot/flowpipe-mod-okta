pipeline "list_groups_assign_to_application" {
  title       = "Application Group Assignments Listing"
  description = "List groups assign to an application by ID."

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

  param "app_id" {
    description = "ID of an application."
    type        = string
  }

  step "http" "list_groups_assign_to_application" {
    method = "get"
    url    = "${param.domain}/api/v1/apps/${param.app_id}/groups"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "groupAssigned" {
    description = "Group assignment details of an application"
    value       = step.http.list_groups_assign_to_application.response_body
  }
}
