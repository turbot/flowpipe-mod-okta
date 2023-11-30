pipeline "list_member_users" {
  title       = "List Member Users"
  description = "Lists all users that are a member of a group."

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

  step "http" "list_member_users" {
    method = "get"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users?limit=1000"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "group_members" {
    description = "List of users that are members of the group."
    value       = step.http.list_member_users.response_body
  }
}
