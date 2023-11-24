pipeline "list_member_users" {
  title       = "List Member Users"
  description = "Lists all users that are a member of a group."

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

  step "http" "list_member_users" {
    method = "get"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }


  output "group_members" {
    value       = step.http.list_member_users.response_body
    description = "List of users that are members of the group."
  }
}
