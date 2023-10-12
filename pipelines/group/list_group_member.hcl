pipeline "list_group_member" {
  title       = "List Group Members"
  description = "List members of a group by ID."

  param "token" {
    type        = string
    description = "The Okta personal access token to authenticate to the okta APIs."
    default     = var.token
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

  step "http" "list_group_member" {
    method = "get"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }


  output "groupMembers" {
    description = "Member details of a group."
    value       = step.http.list_group_member.response_body
  }
  output "response_headers" {
    value = step.http.list_group_member.response_headers
  }
  output "status_code" {
    value = step.http.list_group_member_app.status_code
  }

}
