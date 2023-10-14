pipeline "list_group_members" {
  title       = "List Group Members"
  description = "List members of a group by ID."

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

  step "http" "list_group_members" {
    method = "get"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }


  output "groupMembers" {
    description = "Member details of a group."
    value       = step.http.list_group_members.response_body
  }
}
